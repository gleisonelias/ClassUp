# ClassUp

Este repositório contém o código-fonte mínimo da plataforma em arquivos estáticos.

## Arquivos incluídos

- `index.html`
- `styles.css`
- `script.js`
- `publish-to-github.sh`
- `publish-to-github.ps1`
- `publish-main-and-work.sh`
- `README.md`

## Rodar localmente

```bash
python3 -m http.server 4173
```

Acesse: `http://localhost:4173`.

## Publicar no GitHub (`main`)

No PowerShell (ou terminal com Git), dentro da pasta do projeto:

```powershell
git add .
git commit -m "feat: add ClassUp platform files"
git push -u origin HEAD:main
```

## Publicar com script PowerShell

```powershell
.\publish-to-github.ps1 -RepoUrl https://github.com/SEU_USUARIO/NOME_DO_REPO.git -TargetBranch main
```

## Diagnóstico rápido (quando o GitHub aparece vazio)

```powershell
pwd
git remote -v
git branch --show-current
git log --oneline -n 3
git ls-files
```

Se `git ls-files` não mostrar `index.html`, `styles.css` e `script.js`, você está em outra pasta/clone.


## Diagnóstico automático (bash)

Se quiser validar rapidamente se este clone tem os arquivos corretos e se o `origin` está configurado, rode:

```bash
./debug-github-sync.sh
```

Esse script mostra branch atual, commits locais, arquivos versionados e referências remotas.


## Publicar o mesmo conteúdo em `main` e `work`

Se você quiser garantir os dois branches com os mesmos arquivos, rode no terminal da pasta do projeto:

```bash
./publish-main-and-work.sh https://github.com/SEU_USUARIO/NOME_DO_REPO.git
```

Esse comando publica o branch local atual em ambos os destinos remotos:

- `origin/main`
- `origin/work`
