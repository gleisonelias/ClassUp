# ClassUp

Arquivos da plataforma estática prontos para publicação no branch `main`.

## Como executar localmente

```bash
python3 -m http.server 4173
```

Depois acesse: `http://localhost:4173`.

## Arquivos da plataforma

- `index.html`: tela inicial + painel da turma.
- `styles.css`: estilos da landing page e do painel.
- `script.js`: interação do botão de entrada e atualização de status.
- `publish-to-github.sh`: helper para publicar branch local no GitHub (bash).
- `publish-to-github.ps1`: helper para publicar branch local no GitHub (PowerShell).

## Publicar no GitHub (`main`) com comando direto

No PowerShell (ou terminal com Git), dentro da pasta do projeto:

```powershell
git add .
git commit -m "feat: add ClassUp platform files"
git push -u origin HEAD:main
```

## Publicar no GitHub (`main`) com script PowerShell

```powershell
.\publish-to-github.ps1 -RepoUrl https://github.com/SEU_USUARIO/NOME_DO_REPO.git -TargetBranch main
```

## Diagnóstico rápido quando o GitHub continua vazio

Rode estes comandos na mesma pasta onde estão os arquivos:

```powershell
pwd
git remote -v
git branch --show-current
git log --oneline -n 3
git ls-files
```

Se `git ls-files` não listar `index.html`, `styles.css` e `script.js`, você está em outro clone/pasta.
