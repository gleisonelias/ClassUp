param(
  [Parameter(Mandatory = $true)]
  [string]$RepoUrl,

  [string]$TargetBranch = "main"
)

$ErrorActionPreference = "Stop"

function Fail($Message) {
  Write-Host "Erro: $Message" -ForegroundColor Red
  exit 1
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Fail "Git não encontrado. Instale em https://git-scm.com/download/win e reabra o PowerShell."
}

if (-not (Test-Path ".git")) {
  Fail "Esta pasta não é um repositório Git. Entre na pasta correta do projeto antes de executar."
}

$CurrentBranch = (git branch --show-current).Trim()
if ([string]::IsNullOrWhiteSpace($CurrentBranch)) {
  Fail "Não foi possível detectar o branch atual."
}

$Status = git status --porcelain
if ($Status) {
  Fail "Há mudanças não commitadas. Rode 'git add .', 'git commit -m ...' e tente novamente."
}

$TrackedFiles = git ls-files
if (-not $TrackedFiles) {
  Fail "Não há arquivos versionados neste repositório."
}

$RemoteExists = $true
try {
  $null = git remote get-url origin 2>$null
} catch {
  $RemoteExists = $false
}

if ($RemoteExists) {
  git remote set-url origin $RepoUrl | Out-Null
} else {
  git remote add origin $RepoUrl | Out-Null
}

Write-Host "Branch atual: $CurrentBranch"
Write-Host "Publicando para: origin/$TargetBranch"

git push -u origin "$CurrentBranch`:$TargetBranch"

Write-Host "Push concluído." -ForegroundColor Green
