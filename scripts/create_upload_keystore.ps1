# Google Play upload keystore oluşturur.
# Çıktı: android/app/upload-keystore.jks ve android/key.properties (örnek şifrelerle)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
$keystorePath = Join-Path $projectRoot "android\app\upload-keystore.jks"
$keyPropsPath = Join-Path $projectRoot "android\key.properties"

if (Test-Path $keystorePath) {
    Write-Host "Keystore zaten mevcut: $keystorePath"
    exit 0
}

$keytool = "keytool"
if (-not (Get-Command $keytool -ErrorAction SilentlyContinue)) {
    $javaHome = $env:JAVA_HOME
    if ($javaHome) {
        $keytool = Join-Path $javaHome "bin\keytool.exe"
    }
}

$storePass = "TokatPersonelim2026!"
$keyPass = $storePass
$dname = "CN=Tokat Belediyesi Personel, OU=Bilgi Islem, O=Tokat Belediyesi, L=Tokat, ST=Tokat, C=TR"

& $keytool -genkeypair -v `
    -storetype PKCS12 `
    -keystore $keystorePath `
    -alias upload `
    -keyalg RSA `
    -keysize 2048 `
    -validity 10000 `
    -storepass $storePass `
    -keypass $keyPass `
    -dname $dname

@"
storePassword=$storePass
keyPassword=$keyPass
keyAlias=upload
storeFile=app/upload-keystore.jks
"@ | Set-Content -Path $keyPropsPath -Encoding UTF8

Write-Host ""
Write-Host "Keystore olusturuldu: $keystorePath"
Write-Host "key.properties olusturuldu: $keyPropsPath"
Write-Host "ONEMLI: Sifreleri kurum guvenli depolamasinda saklayin. Play Console guncellemeleri icin ayni keystore zorunludur."
