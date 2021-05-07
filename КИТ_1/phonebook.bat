@echo off

rem cathing parameters	
if .%1. == ./?. goto _help
if .%1. == .. goto no_params
if %1 == /w goto write
if %1 == /r goto read

rem writing to book
:write
if ?%2 == ? goto wrong_params
if ?%3 == ? goto wrong_params
echo %2 %3 >> book
goto exit

rem reading from book
:read
if –%2 == – goto wrong_params
find %2 book
goto exit

rem utilities
:_help
echo Read-Write cmd phoonebook
echo.
echo Use /w parameter with name and phone number:
echo Example: "> phonebook.bat /w 'Andrei Shvedau' +37544"
echo.
echo Use /r parameter for reading data from book. You need to specify a name.
echo Example: "> phonebook.bat /r 'Andrei Shvedau'"
echo.
echo @ Andrei Shvedau
goto exit

:no_params
echo Specify params! Use /? if needed.
goto exit

:wrong_params
echo Specify 3 params for writing data! Use /? if needed.
goto exit

rem finish the programm
:exit