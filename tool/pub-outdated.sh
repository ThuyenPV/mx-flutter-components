#!/bin/sh

set -e

(flutter pub outdated)
(cd ./packages/mx_crypto_repository && pwd && flutter pub outdated)
(cd ./packages/mx_crypto_ui && pwd && flutter pub outdated)
(cd ./packages/mx_share_api && pwd && flutter pub outdated)