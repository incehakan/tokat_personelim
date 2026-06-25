# iOS imzasiz IPA teslim paketi (kaynak kod YOK).
# Kullanim: .\scripts\create_ios_delivery_package.ps1

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

$version = "1.3.4"
if (Test-Path "pubspec.yaml") {
    $pubspec = Get-Content "pubspec.yaml" -Raw
    if ($pubspec -match 'version:\s*([0-9.]+)\+') {
        $version = $Matches[1]
    }
}

$ipaFile = "release\TokatPersonelim-v$version-unsigned.ipa"
if (-not (Test-Path $ipaFile)) {
    Write-Host "Imzasiz IPA bulunamadi: $ipaFile" -ForegroundColor Red
    Write-Host ""
    Write-Host "Once Codemagic'te su workflow ile build alin:" -ForegroundColor Yellow
    Write-Host "  Tokat Personelim iOS (Imzasiz)"
    Write-Host ""
    Write-Host "Build bitince IPA'yi release/ klasorune koyun ve tekrar calistirin."
    exit 1
}

$stagingDir = Join-Path $projectRoot "release\_ios_teslim_staging"
$zipPath = Join-Path $projectRoot "release\TokatPersonelim-v$version-ios-teslim.zip"

if (Test-Path $stagingDir) { Remove-Item -Recurse -Force $stagingDir }
New-Item -ItemType Directory -Force -Path $stagingDir | Out-Null

Copy-Item $ipaFile $stagingDir
Copy-Item "release\KURUM_IOS_TESLIM.txt" $stagingDir -ErrorAction SilentlyContinue
Copy-Item "release\SURUM_NOTLARI_v$version.txt" $stagingDir -ErrorAction SilentlyContinue
Copy-Item "docs\KURUM_IOS_IMZALAMA.md" $stagingDir

if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
Compress-Archive -Path "$stagingDir\*" -DestinationPath $zipPath -Force
Remove-Item -Recurse -Force $stagingDir

Write-Host ""
Write-Host "iOS teslim paketi:" -ForegroundColor Green
Write-Host "  $zipPath"
Write-Host ""
Write-Host "Kuruma bu ZIP'i verin. Kaynak kod DAHIL DEGIL." -ForegroundColor Cyan
