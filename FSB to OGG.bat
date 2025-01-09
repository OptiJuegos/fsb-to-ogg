@echo off
cd "%~dp0"

set OGG="%CD%\components\oggenc2.exe"
set FSB="%CD%\components\vgmstream-cli.exe"
set FFMPEG="%CD%\components\ffmpeg.exe"
set OPTI="%CD%\components\optivorbis.exe"

rem Convertir
title Optimizar Audios Minecraft

rem Establecer la ruta de la carpeta principal
set "mainFolder=%CD%\sounds"

rem comprobar si existe la carpeta
if exist "%mainFolder%" (
    goto :FSBtoWAV
) else (
    goto :Error
)

:FSBtoWAV
rem Recorrer todas las carpetas y subcarpetas
for /r "%mainFolder%" %%d in (.) do (
    cd "%%d"
    for %%f in (*.fsb) do (
        %FSB% "%%f" -o "%%~nf.wav"
    )
)

:FSBDelete
rem Borrar archivos .fsb
for /r "%mainFolder%" %%d in (.) do (
    cd "%%d"
    for %%f in (*.fsb) do (
        del "%%f"
    )
)

:WAVtoOGG
rem Convertir .wav a .ogg
for /r "%mainFolder%" %%d in (.) do (
    cd "%%d"
    for %%f in (*.wav) do (
        %OGG% "%%f" -q -1 -s 0 --max-bitrate 64.00k --managed
    )
)

:WAVDelete
rem Borrar archivos .wav
for /r "%mainFolder%" %%d in (.) do (
    cd "%%d"
    for %%f in (*.wav) do (
        del "%%f"
    )
)

cls
echo terminado
pause
exit

:Error
echo no esta la carpeta sounds bobo
pause