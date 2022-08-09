#!/bin/bash

set -e

(flutter test && echo 'mx_flutter_components OK')
(cd ./packages/mx_crypto_ui && flutter test && echo 'packages/mx_crypto_ui OK')
(cd ./packages/mx_crypto_repository && flutter test && echo 'packages/mx_crypto_repository OK')
(cd ./packages/mx_share_api && flutter test && echo 'packages/mx_share_api OK')
