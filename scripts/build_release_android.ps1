# Android release derlemesi (APK + AAB) ve release/ klasörüne kopyalama.
# Kullanım: .\scripts\build_release_android.ps1
# Opsiyonel: .\scripts\build_release_android.ps1 -VersionName 1.3.4 -VersionCode 5

param(
    [string]$VersionName = "",
    [int]$VersionCode = 0
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

$keyProps = Join-Path $projectRoot "android\key.properties"
$keystore = Join-Path $projectRoot "android\app\upload-keystore.jks"

if (-not (Test-Path $keyProps) -or -not (Test-Path $keystore)) {
    Write-Host "Keystore bulunamadi. Once calistirin: .\scripts\create_upload_keystore.ps1" -ForegroundColor Yellow
    exit 1
}

if ($VersionName -eq "" -or $VersionCode -eq 0) {
    $pubspec = Get-Content "pubspec.yaml" -Raw
    if ($pubspec -match 'version:\s*([0-9.]+)\+(\d+)') {
        if ($VersionName -eq "") { $VersionName = $Matches[1] }
        if ($VersionCode -eq 0) { $VersionCode = [int]$Matches[2] }
    } else {
        throw "pubspec.yaml icinde version satiri okunamadi."
    }
}

Write-Host "Sürüm: $VersionName (build $VersionCode)" -ForegroundColor Cyan

flutter pub get
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$buildArgs = @(
    "--release",
    "--build-name=$VersionName",
    "--build-number=$VersionCode"
)

Write-Host "`n[1/2] APK derleniyor..." -ForegroundColor Green
flutter build apk @buildArgs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "`n[2/2] App Bundle (AAB) derleniyor..." -ForegroundColor Green
flutter build appbundle @buildArgs
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$releaseDir = Join-Path $projectRoot "release"
New-Item -ItemType Directory -Force -Path $releaseDir | Out-Null

$apkSrc = Join-Path $projectRoot "build\app\outputs\flutter-apk\app-release.apk"
$aabSrc = Join-Path $projectRoot "build\app\outputs\bundle\release\app-release.aab"
$apkDst = Join-Path $releaseDir "TokatPersonelim-v$VersionName-release.apk"
$aabDst = Join-Path $releaseDir "TokatPersonelim-v$VersionName-playstore.aab"

Copy-Item -Force $apkSrc $apkDst
Copy-Item -Force $aabSrc $aabDst

Write-Host "`nTamamlandi:" -ForegroundColor Green
Write-Host "  APK: $apkDst"
Write-Host "  AAB: $aabDst"
Write-Host "`nPlay Store: $aabDst dosyasini Play Console'a yukleyin."
Write-Host "Kurum ici kurulum: $apkDst dosyasini cihaza aktarin."
