#!/usr/bin/env bash
# iOS App Store release derlemesi (yalnizca macOS + Xcode gerekir).
# Kullanım: ./scripts/build_release_ios.sh

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

VERSION_LINE=$(grep '^version:' pubspec.yaml | awk '{print $2}')
VERSION_NAME="${VERSION_LINE%%+*}"
VERSION_CODE="${VERSION_LINE##*+}"

echo "Sürüm: $VERSION_NAME (build $VERSION_CODE)"

flutter pub get
cd ios
pod install
cd ..

echo "[1/2] IPA derleniyor..."
flutter build ipa --release \
  --build-name="$VERSION_NAME" \
  --build-number="$VERSION_CODE" \
  --export-options-plist=ios/ExportOptions.plist

RELEASE_DIR="$PROJECT_ROOT/release"
mkdir -p "$RELEASE_DIR"

IPA_SRC=$(find "$PROJECT_ROOT/build/ios/ipa" -name "*.ipa" | head -n 1)
IPA_DST="$RELEASE_DIR/TokatPersonelim-v${VERSION_NAME}-appstore.ipa"

if [[ -f "$IPA_SRC" ]]; then
  cp -f "$IPA_SRC" "$IPA_DST"
  echo ""
  echo "Tamamlandi: $IPA_DST"
  echo ""
  echo "App Store'a yuklemek icin:"
  echo "  1. Transporter uygulamasini acin (Mac App Store)"
  echo "  2. IPA dosyasini surukleyip birakin"
  echo "  veya: xcrun altool --upload-app -f \"$IPA_DST\" -t ios -u APPLE_ID -p APP_SPECIFIC_PASSWORD"
else
  echo "IPA bulunamadi. Xcode ile manuel archive deneyin: docs/APP_STORE_YAYINLAMA.md"
  exit 1
fi
