#!/bin/bash

cd ..
rm -rf HelloWorld.deps.zip
zip HelloWorld.deps.zip modules modules/*
cd -
