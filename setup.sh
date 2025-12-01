#!/bin/bash
pip install -U commitizen --break-system-packages
pip install pre-commit --break-system-packages
pre-commit install --hook-type commit-msg
pre-commit autoupdate
