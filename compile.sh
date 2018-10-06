#!/bin/bash

# Script para compilar o material do curso

cd src-material
Rscript compile.R
cd ../docs

cp introducao.html index.html
