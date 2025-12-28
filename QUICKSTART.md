# Emacs C++ & Python Development Environment - Quick Start Guide

## 📋 Post-Installation Checklist

### 1. Erste Schritte nach Installation

1. **Terminal schließen und neu öffnen** (wichtig für PATH!)

2. **Emacs starten:**
   ```bash
   emacs
   ```

3. **Beim ersten Start:**
   - Emacs lädt automatisch alle Pakete herunter (dauert 2-5 Minuten)
   - Du siehst viele Meldungen im `*Messages*` Buffer
   - **WARTEN bis "Package refresh done" erscheint**
   - Dann Emacs schließen (`C-x C-c`) und neu starten

4. **Überprüfe ob alles installiert ist:**
   ```bash
   emacs --version
   git --version
   python --version
   cmake --version
   ```

---

## ⌨️ Die wichtigsten Emacs Keybindings

### Notation
- `C-` = Strg/Ctrl
- `M-` = Alt (Meta)
- `S-` = Shift
- `C-x` dann `C-f` = Erst `Strg+X`, dann `Strg+F`

---

## 🔰 Absolute Basics (MUST KNOW!)

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-x C-f` | **Datei öffnen** (Find file) |
| `C-x C-s` | **Datei speichern** (Save) |
| `C-x C-w` | **Speichern unter** (Write) |
| `C-x C-c` | **Emacs beenden** (Close) |
| `C-g` | **Abbrechen** (wichtigste Taste!) |
| `C-x b` | **Buffer wechseln** |
| `C-x k` | **Buffer schließen** (Kill) |
| `C-x 1` | **Nur aktuelles Fenster** |
| `C-x 2` | **Horizontal teilen** |
| `C-x 3` | **Vertikal teilen** |
| `C-x o` | **Zwischen Fenstern wechseln** (Other) |

---

## 📝 Text-Editing Basics

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-space` | **Mark setzen** (Selection starten) |
| `C-w` | **Cut** (Marked region) |
| `M-w` | **Copy** (Marked region) |
| `C-y` | **Paste** (Yank) |
| `C-k` | **Zeile löschen** (Kill line) |
| `C-a` | **Zeilenanfang** |
| `C-e` | **Zeilenende** |
| `M-<` | **Datei-Anfang** |
| `M->` | **Datei-Ende** |
| `C-s` | **Suchen vorwärts** (Swiper) |
| `C-r` | **Suchen rückwärts** |
| `M-%` | **Suchen & Ersetzen** |

---

## 🚀 Moderne Features (aus der Config)

### Ivy/Counsel (Fuzzy Search überall)

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `M-x` | **Command ausführen** (mit Fuzzy-Search) |
| `C-x C-f` | **Datei öffnen** (mit Fuzzy-Search) |
| `C-x b` | **Buffer wechseln** (mit Fuzzy-Search) |
| `C-s` | **Swiper suchen** (besseres Search) |

**Tipp:** In allen Ivy-Menüs:
- `C-j` / `C-k` = Hoch/Runter navigieren
- `TAB` = Auswählen
- `C-g` = Abbrechen

---

## 🗂️ Projectile (Project Management)

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-c p p` | **Projekt wechseln** |
| `C-c p f` | **Datei im Projekt finden** |
| `C-c p s g` | **Im Projekt suchen** (grep) |
| `C-c p c` | **Compile Project** |
| `C-c p r` | **Project ersetzen** |

---

## 🌳 Treemacs (File Explorer)

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-x t t` | **Treemacs toggle** |
| `M-0` | **Zu Treemacs wechseln** |
| `j/k` | **Hoch/Runter** (im Treemacs) |
| `RET` | **Datei öffnen** |
| `c` | **Datei erstellen** |
| `d` | **Datei löschen** |
| `R` | **Datei umbenennen** |

---

## 🔧 LSP (Language Server - das Wichtigste!)

### Automatisch aktiv für C++/Python wenn Datei geöffnet

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-c l g g` | **Gehe zu Definition** |
| `C-c l g r` | **Finde Referenzen** |
| `C-c l r r` | **Rename Symbol** |
| `C-c l = =` | **Code formatieren** |
| `C-c l a a` | **Code Actions** (Fixes) |
| `M-.` | **Gehe zu Definition** (alternate) |
| `M-,` | **Zurück** |

### Auto-Completion (Company)
- Einfach tippen → Popup erscheint automatisch
- `TAB` = Auswählen
- `C-n` / `C-p` = Hoch/Runter in Liste
- `C-g` = Abbrechen

---

## 🐍 Python Spezifisch

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-c C-c` | **Code ausführen** |
| `C-c C-z` | **Python REPL öffnen** |
| Speichern | **Auto-Format mit Black** |

### Python LSP Features:
- **Automatische Imports**
- **Type Hints**
- **Linting** (Fehler werden rot unterstrichen)
- **Hover für Dokumentation**

---

## 💻 C++ Spezifisch

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-c c` | **Compile** |
| `C-c r` | **Re-compile** |
| `C-c d` | **GDB starten** |
| `M-;` | **Kommentar toggle** |

### C++ LSP (braucht clangd):
```bash
# clangd installieren (für LSP):
# Windows: Teil von LLVM
# Oder: Download von https://clangd.llvm.org/
```

---

## 📦 Git (Magit - Das beste Git-Interface!)

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-x g` | **Git Status öffnen** (Magit) |

### Im Magit Status Buffer:

| Taste | Beschreibung |
|-------|--------------|
| `s` | **Stage** file/hunk |
| `u` | **Unstage** file/hunk |
| `c c` | **Commit** (dann Message eingeben) |
| `P p` | **Push** |
| `F p` | **Pull** |
| `b b` | **Branch wechseln** |
| `b c` | **Branch erstellen** |
| `l l` | **Log anzeigen** |
| `TAB` | **Diff anzeigen/verstecken** |
| `q` | **Magit schließen** |

**Commit Workflow:**
1. `C-x g` → Magit öffnen
2. `s` auf Files → Stagen
3. `c c` → Commit Message eingeben
4. `C-c C-c` → Commit bestätigen
5. `P p` → Push

---

## 🎨 Multiple Cursors

| Tastenkombination | Beschreibung |
|------------------|--------------|
| `C-S-c C-S-c` | **Edit Lines** (Multi-Cursor auf Zeilen) |
| `C->` | **Nächstes Like-This markieren** |
| `C-<` | **Vorheriges Like-This markieren** |
| `C-c C-<` | **Alle Like-This markieren** |

**Beispiel:**
1. Markiere ein Wort
2. `C->` mehrmals drücken
3. Alle Instanzen gleichzeitig editieren!

---

## 🔍 Nützliche Befehle (M-x eingeben dann...)

| Befehl | Beschreibung |
|--------|--------------|
| `describe-key` (oder `C-h k`) | **Was macht diese Taste?** |
| `describe-function` | **Funktion-Dokumentation** |
| `describe-variable` | **Variable anzeigen** |
| `package-list-packages` | **Pakete verwalten** |
| `customize-group` | **Einstellungen GUI** |
| `eval-buffer` | **Config neu laden** |

---

## 🎯 Dein erster C++ Workflow

### 1. Projekt erstellen
```bash
mkdir my-cpp-project
cd my-cpp-project
```

### 2. CMakeLists.txt erstellen
```cmake
cmake_minimum_required(VERSION 3.10)
project(MyProject)

set(CMAKE_CXX_STANDARD 17)

add_executable(main main.cpp)
```

### 3. main.cpp erstellen
```cpp
#include <iostream>

int main() {
    std::cout << "Hello, Emacs!" << std::endl;
    return 0;
}
```

### 4. In Emacs öffnen
```bash
emacs .  # Öffnet Verzeichnis
```

### 5. Im Emacs:
1. `C-c p p` → Projekt auswählen
2. `C-c p f` → `main.cpp` öffnen
3. Code schreiben → **LSP zeigt Fehler/Completion**
4. `C-x C-s` → Speichern
5. `M-x compile RET cmake -B build && cmake --build build` → Kompilieren
6. `M-x shell` → Terminal in Emacs
7. `./build/main` → Ausführen

---

## 🐍 Dein erster Python Workflow

### 1. Python Datei erstellen
```bash
emacs test.py
```

### 2. Code schreiben
```python
def greet(name: str) -> str:
    """Greet someone."""
    return f"Hello, {name}!"

if __name__ == "__main__":
    print(greet("Emacs"))
```

### 3. Im Emacs:
1. Code schreiben → **LSP zeigt Type-Hints**
2. `C-x C-s` → Speichern (Auto-Format mit Black!)
3. `C-c C-c` → Code ausführen
4. `C-c C-z` → Python REPL

---

## ⚙️ Wichtige Anpassungen

### Wo ist die Config?
```
Windows: C:\Users\DEIN_NAME\AppData\Roaming\.emacs.d\init.el
```

### Config bearbeiten:
```
1. C-x C-f
2. ~/.emacs.d/init.el eingeben
3. Änderungen machen
4. C-x C-s (speichern)
5. M-x eval-buffer (Config neu laden)
```

### Nützliche Anpassungen in init.el:

```elisp
;; Font ändern
(set-face-attribute 'default nil :font "Consolas-12")

;; Theme ändern
(load-theme 'doom-dracula t)  ;; statt doom-one

;; Auto-Save weniger aggressiv
(setq auto-save-interval 300)

;; Line numbers ausschalten
(global-display-line-numbers-mode -1)
```

---

## 🔥 Pro-Tips

### 1. **Immer `C-g` im Kopf haben**
Wenn irgendwas hängt oder weird ist → `C-g` mehrmals drücken

### 2. **Undo ist `C-/` oder `C-x u`**
Emacs hat unendliches Undo!

### 3. **Help-System benutzen**
- `C-h k` → "Was macht diese Taste?"
- `C-h f` → "Was macht diese Funktion?"
- `C-h v` → "Was ist diese Variable?"
- `C-h m` → "Hilfe für aktuellen Mode"

### 4. **Befehle finden**
`M-x` dann einfach tippen was du willst → Fuzzy-Search findet alles

### 5. **Buffer wechseln wie ein Pro**
`C-x b` → Einfach ein paar Buchstaben vom Namen tippen → TAB

### 6. **Projectile ist dein Freund**
`C-c p` zeigt ALLE Projekt-Befehle

### 7. **Magit lernen = Git-Productivity x10**
Nimm dir 10 Minuten, lerne Magit → Never go back

---

## 🛠️ Troubleshooting

### LSP startet nicht?
```elisp
M-x lsp-doctor
```
Zeigt was fehlt (z.B. clangd für C++)

### Python LSP Probleme?
```bash
python -m pip install python-lsp-server[all] --upgrade
```

### Packages nicht installiert?
```elisp
M-x package-refresh-contents
M-x package-install RET [package-name]
```

### Emacs lädt ewig?
```
1. Emacs starten mit: emacs --debug-init
2. Zeigt wo der Fehler ist
```

### Config zurücksetzen?
```bash
# Backup der alten Config
mv ~/.emacs.d ~/.emacs.d.backup

# Neue Config wird beim Start erstellt
```

---

## 📚 Weiterführende Ressourcen

### Emacs lernen:
- **Built-in Tutorial:** `C-h t` in Emacs
- **Cheat Sheet:** https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf
- **Mastering Emacs:** https://www.masteringemacs.org/

### LSP:
- **lsp-mode Docs:** https://emacs-lsp.github.io/lsp-mode/
- **clangd Setup:** https://clangd.llvm.org/installation.html

### Magit:
- **Magit Cheatsheet:** https://github.com/magit/magit/wiki/Cheatsheet
- **Video Tutorial:** https://www.youtube.com/watch?v=vQO7F2Q9DwA

---

## 🎓 Lernplan für die ersten 7 Tage

### Tag 1: Navigation
- `C-x C-f` (Datei öffnen)
- `C-x C-s` (Speichern)
- `C-x C-c` (Beenden)
- `C-g` (Abbrechen)
- Navigation: `C-a`, `C-e`, `C-n`, `C-p`

### Tag 2: Editing
- Selection: `C-space`
- Copy/Paste: `M-w`, `C-w`, `C-y`
- Undo: `C-/`
- Search: `C-s`

### Tag 3: Windows & Buffers
- Split: `C-x 2`, `C-x 3`
- Switch: `C-x o`
- Buffer: `C-x b`, `C-x k`

### Tag 4: Projectile
- Projekt öffnen: `C-c p p`
- Datei finden: `C-c p f`
- Im Projekt suchen: `C-c p s g`

### Tag 5: LSP
- Definition: `C-c l g g`
- Referenzen: `C-c l g r`
- Rename: `C-c l r r`
- Code Actions: `C-c l a a`

### Tag 6: Magit
- Status: `C-x g`
- Stage: `s`
- Commit: `c c`
- Push: `P p`

### Tag 7: Customization
- Config öffnen
- Theme ändern
- Eigene Keybindings

---

## 🚀 Quick Reference Card

Drucke das aus und klebe es an die Wand:

```
┌─────────────────────────────────────────┐
│       EMACS SURVIVAL GUIDE              │
├─────────────────────────────────────────┤
│ C-x C-f   │ Open File                   │
│ C-x C-s   │ Save                        │
│ C-x C-c   │ Quit                        │
│ C-g       │ ABORT (wichtigste Taste!)   │
│ C-x b     │ Switch Buffer               │
│ C-space   │ Start Selection             │
│ C-w       │ Cut                         │
│ M-w       │ Copy                        │
│ C-y       │ Paste                       │
│ C-s       │ Search                      │
│ C-/       │ Undo                        │
│ M-x       │ Run Command                 │
│───────────────────────────────────────  │
│ C-c p p   │ Switch Project              │
│ C-c p f   │ Find File in Project        │
│ C-x g     │ Git Status (Magit)          │
│ C-x t t   │ File Explorer (Treemacs)    │
│───────────────────────────────────────  │
│ C-c l g g │ Go to Definition (LSP)      │
│ C-c l r r │ Rename Symbol (LSP)         │
│ C-c l a a │ Code Actions (LSP)          │
└─────────────────────────────────────────┘
```

---

**Viel Erfolg! Nach 1 Woche wirst du nie wieder zu VS Code zurückwollen! 😉**
