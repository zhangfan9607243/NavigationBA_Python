#!/bin/bash
set -e

mkdocs build

cd site
git init
git add .
git commit -m "deploy site"
git branch -M main
git remote remove origin 2>/dev/null || true
git remote add origin git@github.com:NavigationBA/NavigationBA_Basics.git
git push -f origin main
cd ..

cd codes
git init
git add .
git commit -m "deploy codes"
git branch -M main
git remote remove origin 2>/dev/null || true
git remote add origin git@github.com:NavigationBA/NavigationBA_Basics_Code.git
git push -f origin main
cd ..