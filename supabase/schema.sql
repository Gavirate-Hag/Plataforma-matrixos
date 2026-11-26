-- Plataforma MatrixOS: esquema inicial para Supabase (Postgres)
-- Rode no SQL Editor do projeto Supabase.

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text not null,
  empresa text,
  plano text not null default 'Essencial' check (plano in ('Essencial','Pro','Corporate')),
  created_at timestamptz not null default now()
);

create table if not exists public.lesson_progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  trilha_id text not null,
  aula_idx int not null,
  done_at timestamptz not null default now(),
  primary key (user_id, trilha_id, aula_idx)
);

create table if not exists public.saved_solutions (
  user_id uuid not null references auth.users(id) on delete cascade,
  solution_id int not null,
  saved_at timestamptz not null default now(),
  primary key (user_id, solution_id)
);

create table if not exists public.bookings (
  user_id uuid not null references auth.users(id) on delete cascade,
  mentoria_id text not null,
  booked_at timestamptz not null default now(),
  primary key (user_id, mentoria_id)
);

create table if not exists public.posts (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  texto text not null check (char_length(texto) between 1 and 2000),
  tag text not null default 'Estratégia',
  created_at timestamptz not null default now()
);

create table if not exists public.post_likes (
  post_id bigint not null references public.posts(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  primary key (post_id, user_id)
);

-- Segurança por linha: cada membro só altera os próprios dados.
alter table public.profiles enable row level security;
alter table public.lesson_progress enable row level security;
alter table public.saved_solutions enable row level security;
alter table public.bookings enable row level security;
alter table public.posts enable row level security;
alter table public.post_likes enable row level security;

create policy "perfil: ler o próprio" on public.profiles for select using (auth.uid() = id);
create policy "perfil: criar o próprio" on public.profiles for insert with check (auth.uid() = id);
-- O plano não deve ser alterado pelo próprio membro; isso fica para o webhook de pagamento.
create policy "perfil: editar nome e empresa" on public.profiles for update using (auth.uid() = id)
  with check (auth.uid() = id and plano = (select p.plano from public.profiles p where p.id = auth.uid()));

create policy "progresso: dono" on public.lesson_progress for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "salvas: dono" on public.saved_solutions for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "reservas: dono" on public.bookings for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "posts: membros leem" on public.posts for select using (auth.role() = 'authenticated');
create policy "posts: autor cria" on public.posts for insert with check (auth.uid() = user_id);
create policy "posts: autor apaga" on public.posts for delete using (auth.uid() = user_id);

create policy "curtidas: membros leem" on public.post_likes for select using (auth.role() = 'authenticated');
create policy "curtidas: dono" on public.post_likes for insert with check (auth.uid() = user_id);
create policy "curtidas: dono remove" on public.post_likes for delete using (auth.uid() = user_id);

-- Feed com autor e contagem de curtidas
create or replace view public.feed with (security_invoker = true) as
  select p.id, p.texto, p.tag, p.created_at, p.user_id, pr.nome, pr.empresa,
         (select count(*) from public.post_likes l where l.post_id = p.id) as curtidas
  from public.posts p join public.profiles pr on pr.id = p.user_id;

-- Perfis precisam ser legíveis por membros para exibir autores no feed
create policy "perfil: membros leem nome" on public.profiles for select using (auth.role() = 'authenticated');
