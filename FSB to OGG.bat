@echo off
cd "%~dp0"

set OGG="%CD%\components\oggenc2.exe"
set FSB="%CD%\components\vgmstream-cli.exe"
set FFMPEG="%CD%\ffmpeg.exe"

rem Convertir
title Optimizar Audios Minecraft

rem Establecer la ruta de la carpeta principal
set "mainFolder=%CD%\sounds"

rem comprobar si existe la carpeta
if exist "%CD%\sounds" (
	goto :FSBtoWAV
) else (
	goto :Error
)

:FSBtoWAV
rem Recorrer todas las carpetas y subcarpetas
for /r "%mainFolder%" %%d in (.) do (
    rem Cambiar a la carpeta actual
    cd "%%d"
    rem Buscar archivos .fsb en la carpeta actual
    for %%f in (*.fsb) do (
    rem Intentar convertir el archivo .fsb a .wav
    %FSB% "%%f" -o "%%~nf.wav"
    )
)

:FSBDelete
rem Recorrer todas las carpetas y subcarpetas
for /r "%mainFolder%" %%d in (.) do (
    rem Cambiar a la carpeta actual
    cd "%%d"
    rem Buscar archivos .fsb en la carpeta actual
    for %%f in (*.fsb) do (
    rem Intentar convertir el archivo .fsb a .wav
    del "%%f"
    )
)

:WAVtoOGG
rem Recorrer todas las carpetas y subcarpetas
for /r "%mainFolder%" %%d in (.) do (
    rem Cambiar a la carpeta actual
    cd "%%d"
    rem Buscar archivos .fsb en la carpeta actual
    for %%f in (*.wav) do (
    rem WAV to OGG
    %OGG% "%%f"
    )
)


:WAVDelete
rem Recorrer todas las carpetas y subcarpetas
for /r "%mainFolder%" %%d in (.) do (
    rem Cambiar a la carpeta actual
    cd "%%d"
    rem Buscar archivos .fsb en la carpeta actual
    for %%f in (*.wav) do (
    rem Intentar convertir el archivo .fsb a .wav
    del "%%f"
    )
)

cls
echo terminado
pause

:Error
echo no esta la carpeta sounds bobo
pause