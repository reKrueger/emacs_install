@echo off
setlocal enabledelayedexpansion

:: Emacs C++ & Python Development Environment Setup (Batch Version)
:: No Administrator rights required

echo ========================================
echo Emacs Development Environment Setup
echo ========================================
echo.

:: Set installation directory
set "INSTALL_DIR=%LOCALAPPDATA%\DevTools"
echo Installing to: %INSTALL_DIR%
echo.

:: Create installation directory
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)

:: Check for PowerShell (needed for downloads)
where powershell >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: PowerShell not found. Cannot continue.
    pause
    exit /b 1
)

:: Function to add to PATH
set "NEW_PATHS="

:: ==========================================
:: Install Git
:: ==========================================
echo [1/8] Checking Git...
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Git Portable...
    set "GIT_DIR=%INSTALL_DIR%\Git"
    set "GIT_ZIP=%TEMP%\git-portable.7z.exe"
    
    echo Downloading Git...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/PortableGit-2.43.0-64-bit.7z.exe' -OutFile '%GIT_ZIP%' -UseBasicParsing"
    
    echo Extracting Git...
    "%GIT_ZIP%" -o"%GIT_DIR%" -y
    del "%GIT_ZIP%"
    
    set "NEW_PATHS=!NEW_PATHS!;%GIT_DIR%\cmd;%GIT_DIR%\bin"
    echo Git installed successfully!
) else (
    echo Git already installed.
)
echo.

:: ==========================================
:: Install Emacs
:: ==========================================
echo [2/8] Installing Emacs...
set "EMACS_DIR=%INSTALL_DIR%\Emacs"
set "EMACS_INSTALLER=%TEMP%\emacs-installer.exe"

echo Downloading Emacs...
powershell -Command "Invoke-WebRequest -Uri 'https://ftp.gnu.org/gnu/emacs/windows/emacs-29/emacs-29.1_2-installer.exe' -OutFile '%EMACS_INSTALLER%' -UseBasicParsing"

echo Installing Emacs...
"%EMACS_INSTALLER%" /S /D=%EMACS_DIR%
timeout /t 5 /nobreak >nul
del "%EMACS_INSTALLER%"

set "NEW_PATHS=!NEW_PATHS!;%EMACS_DIR%\bin"
echo Emacs installed successfully!
echo.

:: ==========================================
:: Install ripgrep
:: ==========================================
echo [3/8] Installing ripgrep...
set "RG_DIR=%INSTALL_DIR%\ripgrep"
set "RG_ZIP=%TEMP%\ripgrep.zip"

echo Downloading ripgrep...
powershell -Command "$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/BurntSushi/ripgrep/releases/latest'; $asset = $release.assets | Where-Object { $_.name -like '*x86_64-pc-windows-msvc.zip' } | Select-Object -First 1; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile '%RG_ZIP%' -UseBasicParsing"

echo Extracting ripgrep...
powershell -Command "Expand-Archive -Path '%RG_ZIP%' -DestinationPath '%RG_DIR%' -Force"
del "%RG_ZIP%"

:: Find rg.exe in subdirectories
for /r "%RG_DIR%" %%F in (rg.exe) do (
    set "RG_PATH=%%~dpF"
    set "NEW_PATHS=!NEW_PATHS!;!RG_PATH!"
    goto :rg_found
)
:rg_found
echo ripgrep installed successfully!
echo.

:: ==========================================
:: Install fd
:: ==========================================
echo [4/8] Installing fd...
set "FD_DIR=%INSTALL_DIR%\fd"
set "FD_ZIP=%TEMP%\fd.zip"

echo Downloading fd...
powershell -Command "$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/sharkdp/fd/releases/latest'; $asset = $release.assets | Where-Object { $_.name -like '*x86_64-pc-windows-msvc.zip' } | Select-Object -First 1; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile '%FD_ZIP%' -UseBasicParsing"

echo Extracting fd...
powershell -Command "Expand-Archive -Path '%FD_ZIP%' -DestinationPath '%FD_DIR%' -Force"
del "%FD_ZIP%"

:: Find fd.exe in subdirectories
for /r "%FD_DIR%" %%F in (fd.exe) do (
    set "FD_PATH=%%~dpF"
    set "NEW_PATHS=!NEW_PATHS!;!FD_PATH!"
    goto :fd_found
)
:fd_found
echo fd installed successfully!
echo.

:: ==========================================
:: Install Node.js
:: ==========================================
echo [5/8] Installing Node.js...
set "NODE_DIR=%INSTALL_DIR%\Node"
set "NODE_ZIP=%TEMP%\node.zip"

echo Downloading Node.js...
powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.10.0/node-v20.10.0-win-x64.zip' -OutFile '%NODE_ZIP%' -UseBasicParsing"

echo Extracting Node.js...
powershell -Command "Expand-Archive -Path '%NODE_ZIP%' -DestinationPath '%NODE_DIR%' -Force"
del "%NODE_ZIP%"

:: Find node.exe in subdirectories
for /r "%NODE_DIR%" %%F in (node.exe) do (
    set "NODE_PATH=%%~dpF"
    set "NEW_PATHS=!NEW_PATHS!;!NODE_PATH!"
    goto :node_found
)
:node_found
echo Node.js installed successfully!
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
    
    echo Extracting Python...
    powershell -Command "Expand-Archive -Path '%PYTHON_ZIP%' -DestinationPath '%PYTHON_DIR%' -Force"
    del "%PYTHON_ZIP%"
    
    :: Enable pip
    echo import site >> "%PYTHON_DIR%\python311._pth"
    
    :: Download get-pip.py
    echo Installing pip...
    powershell -Command "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile '%PYTHON_DIR%\get-pip.py'"
    "%PYTHON_DIR%\python.exe" "%PYTHON_DIR%\get-pip.py" --no-warn-script-location
    
    set "NEW_PATHS=!NEW_PATHS!;%PYTHON_DIR%;%PYTHON_DIR%\Scripts"
    echo Python installed successfully!
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
powershell -Command "$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/Kitware/CMake/releases/latest'; $asset = $release.assets | Where-Object { $_.name -like '*windows-x86_64.zip' } | Select-Object -First 1; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile '%CMAKE_ZIP%' -UseBasicParsing"

echo Extracting CMake...
powershell -Command "Expand-Archive -Path '%CMAKE_ZIP%' -DestinationPath '%CMAKE_DIR%' -Force"
del "%CMAKE_ZIP%"

:: Find cmake.exe in subdirectories
for /r "%CMAKE_DIR%" %%F in (cmake.exe) do (
    set "CMAKE_PATH=%%~dpF"
    set "NEW_PATHS=!NEW_PATHS!;!CMAKE_PATH!"
    goto :cmake_found
)
:cmake_found
echo CMake installed successfully!
echo.

:: ==========================================
:: Install Ninja
:: ==========================================
echo [8/8] Installing Ninja...
set "NINJA_DIR=%INSTALL_DIR%\Ninja"
set "NINJA_ZIP=%TEMP%\ninja.zip"

echo Downloading Ninja...
powershell -Command "$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/ninja-build/ninja/releases/latest'; $asset = $release.assets | Where-Object { $_.name -like '*win.zip' } | Select-Object -First 1; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile '%NINJA_ZIP%' -UseBasicParsing"

echo Extracting Ninja...
powershell -Command "Expand-Archive -Path '%NINJA_ZIP%' -DestinationPath '%NINJA_DIR%' -Force"
del "%NINJA_ZIP%"

set "NEW_PATHS=!NEW_PATHS!;%NINJA_DIR%"
echo Ninja installed successfully!
echo.

:: ==========================================
:: Install Python LSP tools
:: ==========================================
echo Installing Python development tools...
where python >nul 2>nul
if %errorlevel% equ 0 (
    python -m pip install --upgrade pip --no-warn-script-location
    python -m pip install python-lsp-server[all] black isort flake8 mypy autopep8 yapf --no-warn-script-location
    echo Python tools installed successfully!
) else (
    echo Python not found, skipping LSP tools installation.
)
echo.

:: ==========================================
:: Update User PATH
:: ==========================================
echo Updating PATH...
powershell -Command "$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'User'); $newPaths = '%NEW_PATHS%'; if ($currentPath -notlike '*' + $newPaths + '*') { [Environment]::SetEnvironmentVariable('PATH', $currentPath + $newPaths, 'User') }"
echo PATH updated!
echo.

:: ==========================================
:: Create Emacs configuration
:: ==========================================
echo Creating Emacs configuration...
set "EMACS_CONFIG_DIR=%APPDATA%\.emacs.d"
if not exist "%EMACS_CONFIG_DIR%" (
    mkdir "%EMACS_CONFIG_DIR%"
)

:: Write init.el
(
echo ;; Emacs Configuration for C++ and Python Development
echo ;; Generated by Batch setup script
echo.
echo ;; Package management setup
echo ^(require 'package^)
echo ^(setq package-archives '^(^("melpa" . "https://melpa.org/packages/"^)
echo                          ^("gnu" . "https://elpa.gnu.org/packages/"^)^)^)
echo ^(package-initialize^)
echo.
echo ;; Bootstrap use-package
echo ^(unless ^(package-installed-p 'use-package^)
echo   ^(package-refresh-contents^)
echo   ^(package-install 'use-package^)^)
echo.
echo ^(eval-when-compile
echo   ^(require 'use-package^)^)
echo.
echo ;; Basic UI improvements
echo ^(use-package emacs
echo   :config
echo   ^(setq inhibit-startup-message t^)
echo   ^(setq ring-bell-function 'ignore^)
echo   ^(tool-bar-mode -1^)
echo   ^(menu-bar-mode -1^)
echo   ^(scroll-bar-mode -1^)
echo   ^(global-display-line-numbers-mode 1^)
echo   ^(setq display-line-numbers-type 'relative^)
echo   ^(show-paren-mode 1^)
echo   ^(electric-pair-mode 1^)
echo   ^(global-auto-revert-mode 1^)
echo   ^(setq backup-directory-alist '^(^("." . "~/.emacs.d/backups"^)^)^)
echo   ^(setq auto-save-file-name-transforms '^(^(".*" "~/.emacs.d/auto-save-list/" t^)^)^)^)
echo.
echo ;; Theme
echo ^(use-package doom-themes
echo   :ensure t
echo   :config
echo   ^(setq doom-themes-enable-bold t
echo         doom-themes-enable-italic t^)
echo   ^(load-theme 'doom-one t^)
echo   ^(doom-themes-visual-bell-config^)
echo   ^(doom-themes-org-config^)^)
echo.
echo ;; Ivy/Counsel/Swiper
echo ^(use-package ivy
echo   :ensure t
echo   :diminish
echo   :bind ^(^("C-s" . swiper^)^)
echo   :config
echo   ^(ivy-mode 1^)^)
echo.
echo ^(use-package counsel
echo   :ensure t
echo   :bind ^(^("M-x" . counsel-M-x^)
echo          ^("C-x b" . counsel-ibuffer^)
echo          ^("C-x C-f" . counsel-find-file^)^)^)
echo.
echo ;; Which-key
echo ^(use-package which-key
echo   :ensure t
echo   :diminish which-key-mode
echo   :config
echo   ^(which-key-mode^)
echo   ^(setq which-key-idle-delay 1^)^)
echo.
echo ;; Projectile
echo ^(use-package projectile
echo   :ensure t
echo   :diminish projectile-mode
echo   :config ^(projectile-mode^)
echo   :custom ^(^(projectile-completion-system 'ivy^)^)
echo   :bind-keymap
echo   ^("C-c p" . projectile-command-map^)^)
echo.
echo ^(use-package counsel-projectile
echo   :ensure t
echo   :config ^(counsel-projectile-mode^)^)
echo.
echo ;; LSP Mode
echo ^(use-package lsp-mode
echo   :ensure t
echo   :init
echo   ^(setq lsp-keymap-prefix "C-c l"^)
echo   :hook ^(^(c-mode . lsp^)
echo          ^(c++-mode . lsp^)
echo          ^(python-mode . lsp^)
echo          ^(lsp-mode . lsp-enable-which-key-integration^)^)
echo   :commands lsp
echo   :config
echo   ^(setq lsp-auto-guess-root t^)
echo   ^(setq lsp-prefer-flymake nil^)
echo   ^(setq lsp-file-watch-threshold 2000^)^)
echo.
echo ;; LSP UI
echo ^(use-package lsp-ui
echo   :ensure t
echo   :hook ^(lsp-mode . lsp-ui-mode^)
echo   :custom
echo   ^(lsp-ui-doc-position 'bottom^)^)
echo.
echo ;; Company
echo ^(use-package company
echo   :ensure t
echo   :after lsp-mode
echo   :hook ^(lsp-mode . company-mode^)
echo   :custom
echo   ^(company-minimum-prefix-length 1^)
echo   ^(company-idle-delay 0.0^)^)
echo.
echo ;; Flycheck
echo ^(use-package flycheck
echo   :ensure t
echo   :init ^(global-flycheck-mode^)^)
echo.
echo ;; C++ configuration
echo ^(use-package cc-mode
echo   :config
echo   ^(setq c-default-style "stroustrup"^)
echo   ^(setq c-basic-offset 4^)
echo   ^(add-hook 'c++-mode-hook
echo             ^(lambda ^(^)
echo               ^(setq indent-tabs-mode nil^)
echo               ^(setq tab-width 4^)
echo               ^(c-set-style "stroustrup"^)
echo               ^(auto-fill-mode^)
echo               ^(c-toggle-auto-hungry-state 1^)^)^)^)
echo.
echo ;; CMake
echo ^(use-package cmake-mode
echo   :ensure t
echo   :mode ^("CMakeLists\\\\.txt\\\\'" "\\\\.cmake\\\\'"^)^)
echo.
echo ;; Python configuration
echo ^(use-package python
echo   :config
echo   ^(setq python-indent-offset 4^)
echo   ^(add-hook 'python-mode-hook
echo             ^(lambda ^(^)
echo               ^(setq indent-tabs-mode nil^)
echo               ^(setq tab-width 4^)
echo               ^(setq python-indent-offset 4^)^)^)^)
echo.
echo ;; Python Black
echo ^(use-package python-black
echo   :ensure t
echo   :after python
echo   :hook ^(python-mode . python-black-on-save-mode^)^)
echo.
echo ;; Magit
echo ^(use-package magit
echo   :ensure t
echo   :bind ^("C-x g" . magit-status^)^)
echo.
echo ;; Treemacs
echo ^(use-package treemacs
echo   :ensure t
echo   :defer t
echo   :bind
echo   ^(:map global-map
echo         ^("M-0" . treemacs-select-window^)
echo         ^("C-x t t" . treemacs^)^)^)
echo.
echo ^(use-package treemacs-projectile
echo   :ensure t
echo   :after ^(treemacs projectile^)^)
echo.
echo ;; Multiple cursors
echo ^(use-package multiple-cursors
echo   :ensure t
echo   :bind ^(^("C-S-c C-S-c" . mc/edit-lines^)
echo          ^("C->" . mc/mark-next-like-this^)
echo          ^("C-<" . mc/mark-previous-like-this^)^)^)
echo.
echo ;; Yasnippet
echo ^(use-package yasnippet
echo   :ensure t
echo   :config
echo   ^(yas-global-mode 1^)^)
echo.
echo ^(use-package yasnippet-snippets
echo   :ensure t
echo   :after yasnippet^)
echo.
echo ;; Helpful
echo ^(use-package helpful
echo   :ensure t
echo   :bind
echo   ^([remap describe-function] . helpful-callable^)
echo   ^([remap describe-variable] . helpful-variable^)
echo   ^([remap describe-key] . helpful-key^)^)
echo.
echo ;; Performance
echo ^(setq gc-cons-threshold 100000000^)
echo ^(setq read-process-output-max ^(* 1024 1024^)^)
echo.
echo ;; Windows optimizations
echo ^(when ^(eq system-type 'windows-nt^)
echo   ^(setq w32-pipe-read-delay 0^)
echo   ^(setq w32-get-true-file-attributes nil^)^)
echo.
echo ;; Custom keybindings
echo ^(global-set-key ^(kbd "C-c c"^) 'compile^)
echo ^(global-set-key ^(kbd "C-c r"^) 'recompile^)
echo ^(global-set-key ^(kbd "C-c d"^) 'gdb^)
echo.
echo ;; Desktop save
echo ^(desktop-save-mode 1^)
echo.
echo ^(message "Emacs configuration loaded successfully!"^)
) > "%EMACS_CONFIG_DIR%\init.el"

echo Emacs configuration created!
echo.

:: ==========================================
:: Summary
:: ==========================================
echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo Installation directory: %INSTALL_DIR%
echo.
echo Tools installed:
echo   - Emacs
echo   - Git for Windows
echo   - ripgrep ^& fd
echo   - Node.js
echo   - Python
echo   - CMake ^& Ninja
echo   - Python LSP tools
echo.
echo Configuration:
echo   - Emacs config: %EMACS_CONFIG_DIR%\init.el
echo.
echo IMPORTANT NEXT STEPS:
echo 1. CLOSE this window and REOPEN a new terminal
echo 2. The PATH has been updated for new sessions
echo 3. Run: emacs
echo 4. Wait for packages to download automatically
echo.
echo Verify installation with:
echo   emacs --version
echo   git --version
echo   python --version
echo   cmake --version
echo.
echo Enjoy your Emacs development environment!
echo.
pause
