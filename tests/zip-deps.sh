#!/bin/bash

cd ..
rm -rf Main.deps.zip
zip Main.deps.zip modules modules/*
cd -
