#!/bin/sh

set -e

find . -name 'pubspec.lock' -delete

(rm -f pubspec.lock && flutter pub get && echo 'Done !')
(cd ./packages/mx_crypto_repository && rm -f pubspec.lock && flutter pub get && echo 'Done !')
(cd ./packages/mx_crypto_ui && rm -f pubspec.lock && flutter pub get && echo 'Done !')
(cd ./packages/mx_share_api && rm -f pubspec.lock && flutter pub get && echo 'Done !')
