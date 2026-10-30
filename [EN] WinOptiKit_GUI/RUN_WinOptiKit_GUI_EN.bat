@echo off
cd /d "%~dp0"
start "" powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0WinOptiKit_GUI_EN.ps1"