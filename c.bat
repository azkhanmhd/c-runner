@echo off
setlocal enabledelayedexpansion

REM -------------------------------
REM Check if any argument is provided
REM -------------------------------
if "%~1"=="" (
    echo Usage: c file.c [options] [-- program_args]
    echo Type c -h for help
    exit /b 1
)

REM -------------------------------
REM Help options
REM -------------------------------
set arg=%~1
if /i "%arg%"=="-h" goto :help
if /i "%arg%"=="help" goto :help
if /i "%arg%"=="-help" goto :help
if /i "%arg%"=="--help" goto :help

REM -------------------------------
REM Block any invalid --* argument at start
REM -------------------------------
if not "%arg:~0,2%"=="" (
    if "%arg:~0,2%"=="--" (
        echo Error: invalid or unsupported option "%arg%"
        exit /b 1
    )
)

REM -------------------------------
REM Defaults
REM -------------------------------
set "filename=%1"
set "name=%~n1"
set "compileOnly=0"
set "compiler=gcc"

shift

REM -------------------------------
REM Parse options
REM -------------------------------
:parse
if "%~1"=="" goto :compile

REM -o flag
if /i "%~1"=="-o" (
    if "%~2"=="" (
        echo Error: -o requires a filename
        exit /b 1
    )
    set "name=%~2"
    shift
    shift
    goto :parse
)

REM -c flag (compile only)
if /i "%~1"=="-c" (
    set "compileOnly=1"
    shift
    goto :parse
)

REM -compiler flag
if /i "%~1"=="-compiler" (
    if "%~2"=="" (
        echo Error: -compiler requires a compiler name (e.g., clang)
        exit /b 1
    )
    set "compiler=%~2"
    shift
    shift
    goto :parse
)

REM -- indicates remaining args for program
if "%~1"=="--" (
    shift
    goto :args
)

REM Block any remaining unknown --* option
if not "%~1:~0,2%"=="" (
    if "%~1:~0,2%"=="--" (
        echo Error: invalid or unsupported option "%~1"
        exit /b 1
    )
)

REM Block unknown single-dash options
if not "%~1:~0,1%"=="" (
    if "%~1:~0,1%"=="-" (
        echo Error: invalid or unsupported option "%~1"
        exit /b 1
    )
)

shift
goto :parse

REM -------------------------------
REM Compile the program
REM -------------------------------
:compile
%compiler% "%filename%" -o "%name%.exe"
if %errorlevel% neq 0 (
    echo Compilation failed.
    exit /b %errorlevel%
)

if "%compileOnly%"=="1" (
    echo Compilation successful. Output: %name%.exe
    exit /b 0
)

REM -------------------------------
REM Run program with safe args
REM -------------------------------
:args
"%name%.exe" %*
exit /b

REM -------------------------------
REM Help section
REM -------------------------------
:help
echo.
echo ==================================
echo       C Compile and Run Tool      
echo ==================================
echo Usage:
echo   c file.c                        ^> Compile and run file.c
echo   c file.c -o prog                ^> Compile to prog.exe and run it
echo   c file.c -c                     ^> Compile only (do not run)
echo   c file.c -- args...             ^> Pass arguments to the program
echo   c file.c -compiler clang        ^> Use clang instead of gcc
echo   c -h ^| help ^| -help ^| --help    ^> Show this help message
echo.
exit /b 0
