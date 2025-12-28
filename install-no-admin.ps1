# Emacs setup WITHOUT Administrator requirements
# Modified version that installs to user directories only

param(
    [switch]$SkipGit,
    [switch]$SkipEmacs,
    [switch]$SkipTools,
    [switch]$SkipConfig,
    [string]$InstallPath = "$env:LOCALAPPDATA\DevTools"
)

$ErrorActionPreference = "Stop"

Write-Host "=== Emacs C++ & Python Development Environment Setup (No Admin) ===" -ForegroundColor Green
Write-Host "Installing to: $InstallPath" -ForegroundColor Yellow

# Create installation directory
if (-not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
}

# Function to check if command exists
function Test-Command {
    param($CommandName)
    $null -ne (Get-Command $CommandName -ErrorAction SilentlyContinue)
}

# Function to download and extract ZIP
function Download-AndExtract {
    param(
        [string]$Url,
        [string]$OutputPath,
        [string]$ExtractTo
    )
    
    Write-Host "Downloading from $Url..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $Url -OutFile $OutputPath -UseBasicParsing
    
    Write-Host "Extracting to $ExtractTo..." -ForegroundColor Yellow
    Expand-Archive -Path $OutputPath -DestinationPath $ExtractTo -Force
    Remove-Item $OutputPath -Force
}

# Function to add to USER PATH (no admin needed)
function Add-ToUserPath {
    param([string]$PathToAdd)
    
    $currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    if ($currentPath -notlike "*$PathToAdd*") {
        Write-Host "Adding $PathToAdd to user PATH..." -ForegroundColor Cyan
        [Environment]::SetEnvironmentVariable("PATH", "$currentPath;$PathToAdd", "User")
    }
    
    # Also add to current session
    if ($env:PATH -notlike "*$PathToAdd*") {
        $env:PATH += ";$PathToAdd"
    }
}

# Install Git if not present
if (-not $SkipGit -and -not (Test-Command git)) {
    Write-Host "Installing Git..." -ForegroundColor Cyan
    
    $gitPath = Join-Path $InstallPath "Git"
    $gitZip = Join-Path $env:TEMP "git-portable.zip"
    
    try {
        # Use portable Git
        $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/PortableGit-2.43.0-64-bit.7z.exe"
        
        Write-Host "Downloading Git portable..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $gitUrl -OutFile $gitZip -UseBasicParsing
        
        # Extract (this is a self-extracting archive)
        Write-Host "Extracting Git..." -ForegroundColor Yellow
        Start-Process -FilePath $gitZip -ArgumentList "-o$gitPath", "-y" -Wait -NoNewWindow
        Remove-Item $gitZip -Force
        
        Add-ToUserPath (Join-Path $gitPath "cmd")
        Add-ToUserPath (Join-Path $gitPath "bin")
    } catch {
        Write-Warning "Could not install Git automatically. Please install Git manually from https://git-scm.com/"
    }
}

if (-not $SkipEmacs) {
    Write-Host "Installing Emacs..." -ForegroundColor Cyan
    
    $emacsPath = Join-Path $InstallPath "Emacs"
    $emacsZip = Join-Path $env:TEMP "emacs.zip"
    
    try {
        # Download portable Emacs
        $emacsUrl = "https://ftp.gnu.org/gnu/emacs/windows/emacs-29/emacs-29.1_2-installer.exe"
        $emacsInstaller = Join-Path $env:TEMP "emacs-installer.exe"
        
        Write-Host "Downloading Emacs..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $emacsUrl -OutFile $emacsInstaller -UseBasicParsing
        
        Write-Host "Installing Emacs (this may take a minute)..." -ForegroundColor Yellow
        # Run installer in silent mode to user directory
        Start-Process -FilePath $emacsInstaller -ArgumentList "/S", "/D=$emacsPath" -Wait -NoNewWindow
        Remove-Item $emacsInstaller -Force
        
        Add-ToUserPath (Join-Path $emacsPath "bin")
    } catch {
        Write-Warning "Could not install Emacs. Error: $_"
        Write-Host "You can download it manually from: https://www.gnu.org/software/emacs/download.html" -ForegroundColor Yellow
    }
    
    # Install ripgrep
    Write-Host "Installing ripgrep..." -ForegroundColor Cyan
    try {
        $rgRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest"
        $rgAsset = $rgRelease.assets | Where-Object { $_.name -like "*x86_64-pc-windows-msvc.zip" } | Select-Object -First 1
        
        if ($rgAsset) {
            $rgPath = Join-Path $InstallPath "ripgrep"
            $rgZip = Join-Path $env:TEMP "ripgrep.zip"
            Download-AndExtract -Url $rgAsset.browser_download_url -OutputPath $rgZip -ExtractTo $rgPath
            
            $rgExe = Get-ChildItem -Path $rgPath -Filter "rg.exe" -Recurse | Select-Object -First 1
            if ($rgExe) {
                Add-ToUserPath $rgExe.DirectoryName
            }
        }
    } catch {
        Write-Warning "Could not install ripgrep: $_"
    }
    
    # Install fd
    Write-Host "Installing fd..." -ForegroundColor Cyan
    try {
        $fdRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/sharkdp/fd/releases/latest"
        $fdAsset = $fdRelease.assets | Where-Object { $_.name -like "*x86_64-pc-windows-msvc.zip" } | Select-Object -First 1
        
        if ($fdAsset) {
            $fdPath = Join-Path $InstallPath "fd"
            $fdZip = Join-Path $env:TEMP "fd.zip"
            Download-AndExtract -Url $fdAsset.browser_download_url -OutputPath $fdZip -ExtractTo $fdPath
            
            $fdExe = Get-ChildItem -Path $fdPath -Filter "fd.exe" -Recurse | Select-Object -First 1
            if ($fdExe) {
                Add-ToUserPath $fdExe.DirectoryName
            }
        }
    } catch {
        Write-Warning "Could not install fd: $_"
    }
}

if (-not $SkipTools) {
    Write-Host "Setting up development tools..." -ForegroundColor Cyan
    
    # Install Node.js
    Write-Host "Installing Node.js..." -ForegroundColor Cyan
    try {
        $nodeUrl = "https://nodejs.org/dist/v20.10.0/node-v20.10.0-win-x64.zip"
        $nodePath = Join-Path $InstallPath "Node"
        $nodeZip = Join-Path $env:TEMP "node.zip"
        
        Download-AndExtract -Url $nodeUrl -OutputPath $nodeZip -ExtractTo $nodePath
        
        $nodeExe = Get-ChildItem -Path $nodePath -Filter "node.exe" -Recurse | Select-Object -First 1
        if ($nodeExe) {
            Add-ToUserPath $nodeExe.DirectoryName
        }
    } catch {
        Write-Warning "Could not install Node.js: $_"
    }
    
    # Install Python (if not already present)
    if (-not (Test-Command python)) {
        Write-Host "Installing Python..." -ForegroundColor Cyan
        try {
            $pythonUrl = "https://www.python.org/ftp/python/3.11.7/python-3.11.7-embed-amd64.zip"
            $pythonPath = Join-Path $InstallPath "Python"
            $pythonZip = Join-Path $env:TEMP "python.zip"
            
            Download-AndExtract -Url $pythonUrl -OutputPath $pythonZip -ExtractTo $pythonPath
            Add-ToUserPath $pythonPath
            
            # Enable pip for embedded Python
            $pipPth = Join-Path $pythonPath "python311._pth"
            if (Test-Path $pipPth) {
                $content = Get-Content $pipPth
                if ($content -notcontains "import site") {
                    Add-Content -Path $pipPth -Value "import site"
                }
            }
            
            # Download and install pip
            Write-Host "Installing pip..." -ForegroundColor Cyan
            $getPip = Join-Path $pythonPath "get-pip.py"
            Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile $getPip
            & (Join-Path $pythonPath "python.exe") $getPip --no-warn-script-location
            
        } catch {
            Write-Warning "Could not install Python: $_"
        }
    }
    
    # Install CMake
    Write-Host "Installing CMake..." -ForegroundColor Cyan
    try {
        $cmakeRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/Kitware/CMake/releases/latest"
        $cmakeAsset = $cmakeRelease.assets | Where-Object { $_.name -like "*windows-x86_64.zip" } | Select-Object -First 1
        
        if ($cmakeAsset) {
            $cmakePath = Join-Path $InstallPath "CMake"
            $cmakeZip = Join-Path $env:TEMP "cmake.zip"
            Download-AndExtract -Url $cmakeAsset.browser_download_url -OutputPath $cmakeZip -ExtractTo $cmakePath
            
            $cmakeExe = Get-ChildItem -Path $cmakePath -Filter "cmake.exe" -Recurse | Select-Object -First 1
            if ($cmakeExe) {
                Add-ToUserPath (Join-Path $cmakeExe.DirectoryName)
            }
        }
    } catch {
        Write-Warning "Could not install CMake: $_"
    }
    
    # Install Ninja
    Write-Host "Installing Ninja..." -ForegroundColor Cyan
    try {
        $ninjaRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/ninja-build/ninja/releases/latest"
        $ninjaAsset = $ninjaRelease.assets | Where-Object { $_.name -like "*win.zip" } | Select-Object -First 1
        
        if ($ninjaAsset) {
            $ninjaPath = Join-Path $InstallPath "Ninja"
            $ninjaZip = Join-Path $env:TEMP "ninja.zip"
            Download-AndExtract -Url $ninjaAsset.browser_download_url -OutputPath $ninjaZip -ExtractTo $ninjaPath
            Add-ToUserPath $ninjaPath
        }
    } catch {
        Write-Warning "Could not install Ninja: $_"
    }
    
    # Note: LLVM requires admin or manual install
    Write-Host "Skipping LLVM/Clang (requires admin rights or manual install)" -ForegroundColor Yellow
    Write-Host "You can install MinGW-w64 or MSYS2 for C++ compilation instead" -ForegroundColor Yellow
    
    # Install Python LSP server and tools
    Write-Host "Installing Python development tools..." -ForegroundColor Cyan
    try {
        if (Test-Command python) {
            & python -m pip install --upgrade pip --no-warn-script-location
            & python -m pip install python-lsp-server[all] black isort flake8 mypy autopep8 yapf --no-warn-script-location
        }
    } catch {
        Write-Warning "Could not install Python LSP tools: $_"
    }
}

# Refresh PATH for current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")

if (-not $SkipConfig) {
    Write-Host "Setting up Emacs configuration..." -ForegroundColor Cyan
    
    # Create Emacs directory
    $emacsDir = "$env:APPDATA\.emacs.d"
    if (-not (Test-Path $emacsDir)) {
        New-Item -ItemType Directory -Path $emacsDir -Force | Out-Null
    }
    
    $initConfig = @"
;; Emacs Configuration for C++ and Python Development
;; Generated by PowerShell setup script (No Admin Version)

;; Package management setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Basic UI improvements
(use-package emacs
  :config
  (setq inhibit-startup-message t)
  (setq ring-bell-function 'ignore)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative)
  (show-paren-mode 1)
  (electric-pair-mode 1)
  (global-auto-revert-mode 1)
  (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
  (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))))

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Ivy/Counsel/Swiper for completion
(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Which-key
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; Projectile for project management
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :ensure t
  :config (counsel-projectile-mode))

;; LSP Mode
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode . lsp)
         (c++-mode . lsp)
         (python-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-auto-guess-root t)
  (setq lsp-prefer-flymake nil)
  (setq lsp-file-watch-threshold 2000))

;; LSP UI
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; LSP Ivy integration
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

;; Company for completion
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
              ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; Flycheck for syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

;; C++ specific configuration
(use-package cc-mode
  :config
  (setq c-default-style "stroustrup")
  (setq c-basic-offset 4)
  
  (add-hook 'c++-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq tab-width 4)
              (c-set-style "stroustrup")
              (auto-fill-mode)
              (c-toggle-auto-hungry-state 1))))

;; CMake support
(use-package cmake-mode
  :ensure t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

;; Python specific configuration
(use-package python
  :config
  (setq python-indent-offset 4)
  
  (add-hook 'python-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq tab-width 4)
              (setq python-indent-offset 4))))

;; Python formatting with Black
(use-package python-black
  :ensure t
  :after python
  :hook (python-mode . python-black-on-save-mode))

;; Magit for Git
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; Treemacs for file explorer
(use-package treemacs
  :ensure t
  :defer t
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

(use-package treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-enable-once))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; Yasnippet for code snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; Helpful for better help
(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Performance optimizations
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; Windows specific optimizations
(when (eq system-type 'windows-nt)
  (setq w32-pipe-read-delay 0)
  (setq w32-get-true-file-attributes nil))

;; Custom keybindings
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c r") 'recompile)
(global-set-key (kbd "C-c d") 'gdb)

;; Save and restore window configuration
(desktop-save-mode 1)

(message "Emacs configuration loaded successfully!")
"@

    # Write configuration to init.el
    $initPath = Join-Path $emacsDir "init.el"
    $initConfig | Out-File -FilePath $initPath -Encoding UTF8
    
    Write-Host "Created Emacs configuration at: $initPath" -ForegroundColor Green
}

Write-Host "`n=== Setup Complete (No Admin)! ===" -ForegroundColor Green
Write-Host "Installation directory: $InstallPath" -ForegroundColor Cyan
Write-Host "`nTools installed:" -ForegroundColor Cyan
Write-Host "- Emacs" -ForegroundColor White
Write-Host "- Git for Windows" -ForegroundColor White
Write-Host "- ripgrep and fd" -ForegroundColor White
Write-Host "- Node.js" -ForegroundColor White
Write-Host "- Python (embedded)" -ForegroundColor White
Write-Host "- CMake and Ninja" -ForegroundColor White
Write-Host "- Python LSP server and tools" -ForegroundColor White

Write-Host "`nNOTE: LLVM/Clang was skipped (requires admin)" -ForegroundColor Yellow
Write-Host "For C++ compilation, consider installing MinGW-w64 or MSYS2 manually" -ForegroundColor Yellow

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. CLOSE and REOPEN your terminal to refresh PATH" -ForegroundColor White
Write-Host "2. Run: emacs" -ForegroundColor White
Write-Host "3. Packages will download automatically on first start" -ForegroundColor White
Write-Host "4. Verify: git --version, python --version, cmake --version" -ForegroundColor White

Write-Host "`nEnjoy your Emacs development environment! 🎉" -ForegroundColor Green
