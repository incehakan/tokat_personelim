# Tokat logosu icin splash ve ikon icin kenar bosluklu kare gorseller uretir.
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$projectRoot = Split-Path -Parent $PSScriptRoot
$sourcePath = Join-Path $projectRoot "assets\icons\tokat_logo.png"
if (-not (Test-Path $sourcePath)) {
    throw "Kaynak logo bulunamadi: $sourcePath"
}

function New-PaddedLogo {
    param(
        [string]$OutputPath,
        [int]$CanvasSize = 1024,
        [double]$LogoScale = 0.58,
        [string]$Background = "white" # white | transparent
    )

    $source = [System.Drawing.Image]::FromFile($sourcePath)
    $canvas = New-Object System.Drawing.Bitmap $CanvasSize, $CanvasSize
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    if ($Background -eq "white") {
        $graphics.Clear([System.Drawing.Color]::White)
    } else {
        $graphics.Clear([System.Drawing.Color]::Transparent)
    }

    $targetSize = [int]($CanvasSize * $LogoScale)
    $ratio = [Math]::Min($targetSize / $source.Width, $targetSize / $source.Height)
    $drawWidth = [int]($source.Width * $ratio)
    $drawHeight = [int]($source.Height * $ratio)
    $x = [int](($CanvasSize - $drawWidth) / 2)
    $y = [int](($CanvasSize - $drawHeight) / 2)

    $graphics.DrawImage($source, $x, $y, $drawWidth, $drawHeight)
    $graphics.Dispose()
    $source.Dispose()

    $dir = Split-Path $OutputPath -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    if ($Background -eq "transparent") {
        $canvas.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } else {
        $canvas.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    $canvas.Dispose()
    Write-Host "Olusturuldu: $OutputPath (scale=$LogoScale)"
}

$iconPath = Join-Path $projectRoot "assets\icons\tokat_logo_icon.png"
$splashPath = Join-Path $projectRoot "assets\icons\tokat_logo_splash.png"

New-PaddedLogo -OutputPath $iconPath -LogoScale 0.52 -Background "transparent"
New-PaddedLogo -OutputPath $splashPath -LogoScale 0.50 -Background "white"

Write-Host "Tamamlandi."
