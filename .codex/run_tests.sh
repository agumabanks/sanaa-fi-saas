#!/usr/bin/env bash
set -euo pipefail
flutter analyze          # static analysis
flutter test --coverage  # unit & widget tests
