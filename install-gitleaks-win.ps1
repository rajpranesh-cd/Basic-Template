Set-ExecutionPolicy Bypass -Scope Process -Force
Write-Host "[INFO] Checking for Chocolatey..."
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "[❌] Chocolatey not found. Please install it first from https://chocolatey.org/install"
    exit 1
}

Write-Host "[INFO] Installing Gitleaks..."
choco install gitleaks -y

Write-Host "[✔] Gitleaks installed:"
gitleaks version
