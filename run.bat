@echo off

if not exist node_modules (
  npm install
) else (
  node test.js
  pause
)
