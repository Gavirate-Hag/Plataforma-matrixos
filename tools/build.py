"""Gera data/catalogo.js a partir de tools/solucoes.txt e tools/formacoes.txt.
Uso: python3 tools/build.py (na raiz do repositório)"""
import json
sols=[]
for l in open('tools/solucoes.txt',encoding='utf-8'):
    l=l.strip()
    if not l or l.startswith('#'):continue
    a,t,tipo,n,h,st,r,d=l.split('|')
    sols.append(dict(id=len(sols)+1,a=a,t=t,tipo=tipo,n=n,h=int(h),st=st.split(','),r=r,d=d))
forms=[]
for l in open('tools/formacoes.txt',encoding='utf-8'):
    l=l.strip()
    if not l or l.startswith('#'):continue
    e,t,n,h,au=l.split('|')
    forms.append(dict(id="f%d"%(len(forms)+1),e=e,t=t,nivel=n,h=int(h),aulas=au.split(';')))
open('data/catalogo.js','w',encoding='utf-8').write("/* Catálogo MatrixOS: gerado por tools/build.py. Edite os .txt em tools/ e rode o script. */\nwindow.MX_SOLS="+json.dumps(sols,ensure_ascii=False)+";\nwindow.MX_FORMACOES="+json.dumps(forms,ensure_ascii=False)+";\n")
print(len(sols),"soluções,",len(forms),"formações")
