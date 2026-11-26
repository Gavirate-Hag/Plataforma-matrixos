# Plataforma MatrixOS

Plataforma de implementação de IA para pequenas e médias empresas: soluções prontas, cases, trilhas, mentorias ao vivo, comunidade e Consultor IA.

## Estado atual

Protótipo navegável em um único arquivo (`index.html`), sem dependências nem build.

- **Site público:** home, catálogo de soluções (busca e filtros), cases, planos (mensal/anual + comparativo), guia de implementação, FAQ.
- **Área de membros:** painel, trilhas com aulas e certificado, biblioteca de soluções, agenda de mentorias, comunidade, Consultor IA, perfil.

Limitações do protótipo: dados, cases, depoimentos e preços são exemplos; o Consultor IA é roteirizado; o estado fica no `localStorage` do navegador.

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
