# Configurar login e banco de dados (Supabase)

1. Crie uma conta e um projeto em https://supabase.com (plano gratuito serve para começar). Região sugerida: São Paulo.
2. No projeto, abra **SQL Editor**, cole o conteúdo de `schema.sql` e clique em **Run**.
3. Em **Authentication → URL Configuration**, coloque em *Site URL*: `https://gavirate-hag.github.io/Plataforma-matrixos/`
4. Em **Project Settings → API**, copie a **Project URL** e a chave **anon public**.
   A chave *anon* é pública por natureza e pode ficar no site. **Nunca** compartilhe a chave *service_role*.
5. Envie a Project URL e a chave anon para o Claude no projeto, que conecta o site ao banco.
