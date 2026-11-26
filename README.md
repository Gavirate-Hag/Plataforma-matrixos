# Plataforma MatrixOS

Plataforma de implementação de IA para pequenas e médias empresas: soluções prontas, cases, trilhas, mentorias ao vivo, comunidade e Consultor IA.

## Estado atual

Protótipo navegável em um único arquivo (`index.html`), sem dependências nem build.

- **Site público:** home, catálogo com **200 soluções** em 8 áreas (busca, filtros por área e tipo), **80 formações** em 8 escolas, **ferramentas**, cases, planos (mensal/anual + comparativo), guia de implementação, FAQ.
- **Ferramentas (funcionam no navegador):** Diagnóstico de maturidade em IA, Calculadora de ROI, Priorizador de casos de uso, Construtor de agentes, Gerador de prompts e Consultor IA.
- **Área de membros:** painel, formações com player de aulas, progresso e certificado, biblioteca de soluções, agenda de mentorias, comunidade, perfil.

## Catálogo

O conteúdo fica em texto simples, fácil de editar:

- `tools/solucoes.txt`: uma solução por linha (`área|título|tipo|nível|horas|ferramentas|resultado|descrição`)
- `tools/formacoes.txt`: uma formação por linha (`escola|título|nível|horas|aula1;aula2;...`)

Depois de editar, rode `python3 tools/build.py` para gerar `data/catalogo.js`.

Limitações do protótipo: as aulas ainda não têm vídeos gravados; cases, depoimentos e preços são exemplos; o Consultor IA é roteirizado; o estado fica no `localStorage` do navegador.

## Como rodar

Abra `index.html` no navegador, ou sirva a pasta:

```bash
python3 -m http.server 8000
# http://localhost:8000
```

## Próximos passos

- Autenticação real e banco de dados
- Pagamentos e assinaturas
- Consultor IA conectado a um modelo de linguagem
- CMS para soluções, trilhas e cases
