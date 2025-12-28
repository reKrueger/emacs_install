@echo off
setlocal enabledelayedexpansion

:: Emacs C++ & Python Development Environment Setup
:: Simple and reliable version

echo ========================================
echo Emacs Development Environment Setup
echo ========================================
echo.

set "INSTALL_DIR=%LOCALAPPDATA%\DevTools"
echo Installing to: %INSTALL_DIR%
echo.

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: ==========================================
:: Install Git
:: ==========================================
echo [1/8] Checking Git...
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Git Portable...
    set "GIT_DIR=%INSTALL_DIR%\Git"
    set "GIT_FILE=%TEMP%\git-portable.7z.exe"
    
    echo Downloading Git...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/PortableGit-2.43.0-64-bit.7z.exe' -OutFile '%GIT_FILE%' -UseBasicParsing"
    
    if exist "%GIT_FILE%" (
        echo Extracting Git...
        "%GIT_FILE%" -o"%GIT_DIR%" -y
        del "%GIT_FILE%"
        echo Git installed!
    ) else (
        echo Git download failed, skipping...
    )
) else (
    echo Git already installed.
)
echo.

:: ==========================================
:: Install Emacs (with dependencies)
:: ==========================================
echo [2/8] Installing Emacs...
set "EMACS_DIR=%INSTALL_DIR%\Emacs"
set "EMACS_ZIP=%TEMP%\emacs-deps.zip"

:: Always clean old installation first
if exist "%EMACS_DIR%" (
    echo Removing old Emacs installation...
    rmdir /s /q "%EMACS_DIR%"
)

echo Downloading Emacs with dependencies (300MB)...
echo This may take 5-10 minutes...
powershell -Command "Invoke-WebRequest -Uri 'https://ftp.gnu.org/gnu/emacs/windows/emacs-29/emacs-29.1.zip' -OutFile '%EMACS_ZIP%' -UseBasicParsing"

if exist "%EMACS_ZIP%" (
    echo Download complete! Extracting...
    powershell -Command "Expand-Archive -Path '%EMACS_ZIP%' -DestinationPath '%EMACS_DIR%' -Force"
    del "%EMACS_ZIP%"
    echo Emacs extracted successfully!
) else (
    echo ERROR: Download failed!
    echo Please check internet connection or download manually from:
    echo https://ftp.gnu.org/gnu/emacs/windows/emacs-29/
)
echo.

:: ==========================================
:: Install ripgrep
:: ==========================================
echo [3/8] Installing ripgrep...
set "RG_DIR=%INSTALL_DIR%\ripgrep"
set "RG_ZIP=%TEMP%\ripgrep.zip"

echo Downloading ripgrep...
powershell -Command "$r=Invoke-RestMethod 'https://api.github.com/repos/BurntSushi/ripgrep/releases/latest';$a=$r.assets|Where-Object{$_.name -like '*x86_64-pc-windows-msvc.zip'}|Select -First 1;Invoke-WebRequest -Uri $a.browser_download_url -OutFile '%RG_ZIP%' -UseBasicParsing"

if exist "%RG_ZIP%" (
    echo Extracting ripgrep...
    powershell -Command "Expand-Archive -Path '%RG_ZIP%' -DestinationPath '%RG_DIR%' -Force"
    del "%RG_ZIP%"
    echo ripgrep installed!
) else (
    echo ripgrep download failed, skipping...
)
echo.

:: ==========================================
:: Install fd
:: ==========================================
echo [4/8] Installing fd...
set "FD_DIR=%INSTALL_DIR%\fd"
set "FD_ZIP=%TEMP%\fd.zip"

echo Downloading fd...
powershell -Command "$r=Invoke-RestMethod 'https://api.github.com/repos/sharkdp/fd/releases/latest';$a=$r.assets|Where-Object{$_.name -like '*x86_64-pc-windows-msvc.zip'}|Select -First 1;Invoke-WebRequest -Uri $a.browser_download_url -OutFile '%FD_ZIP%' -UseBasicParsing"

if exist "%FD_ZIP%" (
    echo Extracting fd...
    powershell -Command "Expand-Archive -Path '%FD_ZIP%' -DestinationPath '%FD_DIR%' -Force"
    del "%FD_ZIP%"
    echo fd installed!
) else (
    echo fd download failed, skipping...
)
echo.

:: ==========================================
:: Install Node.js
:: ==========================================
echo [5/8] Installing Node.js...
set "NODE_DIR=%INSTALL_DIR%\Node"
set "NODE_ZIP=%TEMP%\node.zip"

echo Downloading Node.js...
powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.10.0/node-v20.10.0-win-x64.zip' -OutFile '%NODE_ZIP%' -UseBasicParsing"

if exist "%NODE_ZIP%" (
    echo Extracting Node.js...
    powershell -Command "Expand-Archive -Path '%NODE_ZIP%' -DestinationPath '%NODE_DIR%' -Force"
    del "%NODE_ZIP%"
    echo Node.js installed!
) else (
    echo Node.js download failed, skipping...
)
echo.

:: ==========================================
:: Install Python
:: ==========================================
echo [6/8] Checking Python...
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Python...
    set "PYTHON_DIR=%INSTALL_DIR%\Python"
    set "PYTHON_ZIP=%TEMP%\python.zip"
    
    echo Downloading Python...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.7/python-3.11.7-embed-amd64.zip' -OutFile '%PYTHON_ZIP%' -UseBasicParsing"
    
    if exist "%PYTHON_ZIP%" (
        echo Extracting Python...
        powershell -Command "Expand-Archive -Path '%PYTHON_ZIP%' -DestinationPath '%PYTHON_DIR%' -Force"
        del "%PYTHON_ZIP%"
        
        echo Enabling pip...
        echo import site >> "%PYTHON_DIR%\python311._pth"
        
        echo Installing pip...
        powershell -Command "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile '%PYTHON_DIR%\get-pip.py'"
        "%PYTHON_DIR%\python.exe" "%PYTHON_DIR%\get-pip.py" --no-warn-script-location
        
        echo Python installed!
    ) else (
        echo Python download failed, skipping...
    )
) else (
    echo Python already installed.
)
echo.

:: ==========================================
:: Install CMake
:: ==========================================
echo [7/8] Installing CMake...
set "CMAKE_DIR=%INSTALL_DIR%\CMake"
set "CMAKE_ZIP=%TEMP%\cmake.zip"

echo Downloading CMake...
powershell -Command "$r=Invoke-RestMethod 'https://api.github.com/repos/Kitware/CMake/releases/latest';$a=$r.assets|Where-Object{$_.name -like '*windows-x86_64.zip'}|Select -First 1;Invoke-WebRequest -Uri $a.browser_download_url -OutFile '%CMAKE_ZIP%' -UseBasicParsing"

if exist "%CMAKE_ZIP%" (
    echo Extracting CMake...
    powershell -Command "Expand-Archive -Path '%CMAKE_ZIP%' -DestinationPath '%CMAKE_DIR%' -Force"
    del "%CMAKE_ZIP%"
    echo CMake installed!
) else (
    echo CMake download failed, skipping...
)
echo.

:: ==========================================
:: Install Ninja
:: ==========================================
echo [8/8] Installing Ninja...
set "NINJA_DIR=%INSTALL_DIR%\Ninja"
set "NINJA_ZIP=%TEMP%\ninja.zip"

echo Downloading Ninja...
powershell -Command "$r=Invoke-RestMethod 'https://api.github.com/repos/ninja-build/ninja/releases/latest';$a=$r.assets|Where-Object{$_.name -like '*win.zip'}|Select -First 1;Invoke-WebRequest -Uri $a.browser_download_url -OutFile '%NINJA_ZIP%' -UseBasicParsing"

if exist "%NINJA_ZIP%" (
    echo Extracting Ninja...
    powershell -Command "Expand-Archive -Path '%NINJA_ZIP%' -DestinationPath '%NINJA_DIR%' -Force"
    del "%NINJA_ZIP%"
    echo Ninja installed!
) else (
    echo Ninja download failed, skipping...
)
echo.

:: ==========================================
:: Install Python tools
:: ==========================================
echo Installing Python LSP tools...
where python >nul 2>nul
if %errorlevel% equ 0 (
    python -m pip install --upgrade pip --no-warn-script-location
    python -m pip install python-lsp-server[all] black isort flake8 mypy autopep8 yapf --no-warn-script-location
    echo Python tools installed!
) else (
    echo Python not found, skipping...
)
echo.

:: ==========================================
:: Add to PATH
:: ==========================================
echo Updating PATH...

:: Collect all paths
set "PATHS_TO_ADD="

:: Add Emacs bin
for /r "%EMACS_DIR%" %%F in (emacs.exe) do (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%%~dpF;"
    goto :emacs_path_found
)
:emacs_path_found

:: Add Git if we installed it
if exist "%INSTALL_DIR%\Git\cmd" (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%INSTALL_DIR%\Git\cmd;%INSTALL_DIR%\Git\bin;"
)

:: Add ripgrep
for /r "%RG_DIR%" %%F in (rg.exe) do (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%%~dpF;"
    goto :rg_path_found
)
:rg_path_found

:: Add fd
for /r "%FD_DIR%" %%F in (fd.exe) do (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%%~dpF;"
    goto :fd_path_found
)
:fd_path_found

:: Add Node
for /r "%NODE_DIR%" %%F in (node.exe) do (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%%~dpF;"
    goto :node_path_found
)
:node_path_found

:: Add CMake
for /r "%CMAKE_DIR%" %%F in (cmake.exe) do (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%%~dpF;"
    goto :cmake_path_found
)
:cmake_path_found

:: Add Ninja
if exist "%NINJA_DIR%\ninja.exe" (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%NINJA_DIR%;"
)

:: Add Python if we installed it
if exist "%INSTALL_DIR%\Python\python.exe" (
    set "PATHS_TO_ADD=!PATHS_TO_ADD!%INSTALL_DIR%\Python;%INSTALL_DIR%\Python\Scripts;"
)

:: Update PATH
echo Adding paths to user PATH...
powershell -Command "$current=[Environment]::GetEnvironmentVariable('PATH','User');$new='%PATHS_TO_ADD%'.Split(';')|Where-Object{$_ -and $current -notlike ('*'+$_+'*')};if($new){$updated=$current+';'+($new -join ';');[Environment]::SetEnvironmentVariable('PATH',$updated,'User');Write-Host 'PATH updated!'}"
echo.

:: ==========================================
:: Create Emacs config
:: ==========================================
echo Creating Emacs configuration...
set "EMACS_CONFIG=%APPDATA%\.emacs.d"
if not exist "%EMACS_CONFIG%" mkdir "%EMACS_CONFIG%"

:: Create init.el
powershell -Command "$config=@';; Emacs Configuration for C++ and Python Development;; Generated by install.bat;;; Package management(require ''package)(setq package-archives ''((\"melpa\" . \"https://melpa.org/packages/\") (\"gnu\" . \"https://elpa.gnu.org/packages/\")))(package-initialize);;; Bootstrap use-package(unless (package-installed-p ''use-package) (package-refresh-contents) (package-install ''use-package))(require ''use-package);;; Basic UI(use-package emacs :config (setq inhibit-startup-message t ring-bell-function ''ignore) (tool-bar-mode -1) (menu-bar-mode -1) (scroll-bar-mode -1) (global-display-line-numbers-mode 1) (show-paren-mode 1) (electric-pair-mode 1));;; Theme(use-package doom-themes :ensure t :config (load-theme ''doom-one t));;; Ivy/Counsel(use-package ivy :ensure t :config (ivy-mode 1))(use-package counsel :ensure t :bind ((\"M-x\" . counsel-M-x) (\"C-x C-f\" . counsel-find-file)));;; Which-key(use-package which-key :ensure t :config (which-key-mode));;; Projectile(use-package projectile :ensure t :config (projectile-mode));;; LSP(use-package lsp-mode :ensure t :hook ((c-mode . lsp) (c++-mode . lsp) (python-mode . lsp)) :commands lsp);;; Company(use-package company :ensure t :hook (lsp-mode . company-mode));;; Flycheck(use-package flycheck :ensure t :init (global-flycheck-mode));;; Magit(use-package magit :ensure t :bind (\"C-x g\" . magit-status));;; Python Black(use-package python-black :ensure t :hook (python-mode . python-black-on-save-mode))'@;$config|Out-File -FilePath '%EMACS_CONFIG%\init.el' -Encoding utf8"

echo Emacs config created at: %EMACS_CONFIG%\init.el
echo.

:: ==========================================
:: Summary
:: ==========================================
echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo Installation directory: %INSTALL_DIR%
echo Config directory: %EMACS_CONFIG%
echo.
echo ========================================
echo NEXT STEPS:
echo ========================================
echo 1. CLOSE this terminal window
echo 2. Open a NEW terminal
echo 3. Type: emacs
echo.
echo If emacs command not found:
echo    Run this to find the path:
echo    dir /s /b "%EMACS_DIR%\emacs.exe"
echo.
echo Then use the full path or add to PATH manually.
echo.
echo On first Emacs start:
echo - Wait 2-5 minutes for package downloads
echo - Close and restart Emacs
echo - Ready to use!
echo.
pause
