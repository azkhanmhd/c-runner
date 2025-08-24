# Quick Start: C Compile and Run Tool

A Windows batch script to compile and run C programs.

## Requirements
- Windows OS
- GCC installed and added to your system PATH (Necessary!)

## Setup Instructions
1. Create a folder to store the script, e.g., `C:\Scripts`.
2. Paste `c.bat` (the batch script) inside this folder.
3. Add the folder path to your system's `PATH` environment variable:
   - Press `Win + S`, type `Environment Variables`, and open `Edit the system environment variables`.
   - Click `Environment Variables...`.
   - Under `System variables`, select `Path` → `Edit` → `New`, and add `C:\Scripts`.
   - Click `OK` to save.
4. Open a new Command Prompt to use the script from anywhere.

## Usage

### Compile and run
```bat
c file.c
```
**What it does:** Compiles `file.c` using GCC and runs the resulting executable.
**Output:** Program output is displayed in the console.

### Compile to a custom executable and run
```bat
c file.c -o prog
```
**What it does:** Compiles `file.c` into `prog.exe` and runs it.
**Output:** Executable `prog.exe` is created and its output appears in the console.

### Compile only (do not run)
```bat
c file.c -c
c main.c -c -o test
```
**What it does:** Compiles the specified C file but does not execute it. The optional `-o` flag sets a custom executable name.
**Output:** Executable is created (e.g., `file.exe` or `test.exe`) without running the program.

### Pass arguments to the program
```bat
c file.c -- arg1 arg2
```
**What it does:** Compiles `file.c` and runs it, passing `arg1` and `arg2` as command-line arguments.
**Output:** Program output may vary depending on how it handles arguments.

### Use a different compiler
```bat
c file.c -compiler clang
```
**What it does:** Uses `clang` (or any specified compiler) instead of GCC to compile `file.c`.
**Output:** Compiled executable is generated; console shows compilation messages or errors.

## Help
```bat
c -h
c help
c -help
c --help
```
Displays usage information and all available options.

## Notes
- Compilation errors are shown in the console.
- Executables are created in the same directory as the script.
- The script blocks unsupported options starting with `--` or `-`.
- Crafted With Some VibeCode Magic ✨

---
> Made With ❤️&☕ By Azk 💗

