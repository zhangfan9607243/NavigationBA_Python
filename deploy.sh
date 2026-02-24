#!/bin/bash
set -e
mkdocs build
mkdocs gh-deploy
rm -rf site