# 📘 Emacs Benutzerhandbuch für Einsteiger

## 🎯 Inhaltsverzeichnis

1. [Was ist Emacs?](#was-ist-emacs)
2. [Installation & Erster Start](#installation--erster-start)
3. [Emacs Grundkonzepte](#emacs-grundkonzepte)
4. [Die wichtigsten Tastaturbefehle](#die-wichtigsten-tastaturbefehle)
5. [Arbeiten mit Dateien](#arbeiten-mit-dateien)
6. [Text bearbeiten](#text-bearbeiten)
7. [Fenster & Buffer Management](#fenster--buffer-management)
8. [Projekt-Management mit Projectile](#projekt-management-mit-projectile)
9. [Code-Entwicklung mit LSP](#code-entwicklung-mit-lsp)
10. [Git mit Magit](#git-mit-magit)
11. [C++ Development](#c-development)
12. [Python Development](#python-development)
13. [Emacs anpassen](#emacs-anpassen)
14. [Tipps & Tricks](#tipps--tricks)
15. [Troubleshooting](#troubleshooting)

---

## 📖 Was ist Emacs?

### Die Philosophie

Emacs ist mehr als nur ein Texteditor - es ist eine **erweiterbare Arbeitsumgebung**. Stell dir Emacs wie ein Schweizer Taschenmesser für Entwickler vor: Du kannst damit:

- Code schreiben (C++, Python, JavaScript, etc.)
- Dateien verwalten
- Git bedienen
- E-Mails lesen
- Notizen machen
- Deine Todo-Liste verwalten
- Und vieles mehr!

### Warum Emacs?

**Vorteile:**
- 🚀 **Extrem leistungsfähig**: Kann alles, was moderne IDEs können
- ⌨️ **Tastatur-zentriert**: Arbeite ohne Maus deutlich schneller
- 🔧 **Unendlich anpassbar**: Jede Kleinigkeit kann konfiguriert werden
- 🆓 **Open Source & kostenlos**: Seit 1976 entwickelt und verbessert
- 🔌 **Tausende Erweiterungen**: Für jeden Zweck gibt es ein Package

**Lernkurve:**
Emacs hat eine steile Lernkurve, aber nach 1-2 Wochen wirst du produktiver sein als je zuvor. Diese Anleitung hilft dir dabei!

---

## 🚀 Installation & Erster Start

### Installation durchführen

1. **Installations-Skript ausführen:**
   ```cmd
   cd C:\Users\krueg\Documents\GitHub\emacs_install
   install.bat
   ```

2. **Was wird installiert?**
   - ✅ Emacs 29.1 (neueste stabile Version)
   - ✅ Git (Versionskontrolle)
   - ✅ Python + LSP Server
   - ✅ Node.js (für diverse Tools)
   - ✅ CMake & Ninja (Build-Tools für C++)
   - ✅ ripgrep & fd (schnelle Such-Tools)

3. **Nach der Installation:**
   - Terminal **schließen und neu öffnen** (wichtig für PATH!)
   - Terminal öffnen und eingeben: `emacs`

### Erster Start

Wenn du Emacs das erste Mal startest:

1. **Lade-Phase (2-5 Minuten):**
   - Emacs lädt automatisch alle Packages herunter
   - Du siehst viele Meldungen im `*Messages*` Buffer
   - **WICHTIG:** Warte bis "Package refresh done" erscheint!

2. **Nach dem ersten Start:**
   - Emacs schließen: `Strg + X`, dann `Strg + C`
   - Emacs neu starten: `emacs`
   - Jetzt ist alles einsatzbereit!

### Das Emacs-Fenster

```
┌─────────────────────────────────────────────────────┐
│ Menu Bar (Tool Bar)                                  │ ← Menüleiste
├─────────────────────────────────────────────────────┤
│                                                      │
│                                                      │
│              Haupt-Buffer                            │ ← Dein Text/Code
│              (Text-Bereich)                          │
│                                                      │
│                                                      │
├─────────────────────────────────────────────────────┤
│ Mode Line: init.el (Emacs-Lisp)  [1:1]             │ ← Status-Zeile
├─────────────────────────────────────────────────────┤
│ Minibuffer: M-x _                                    │ ← Befehls-Zeile
└─────────────────────────────────────────────────────┘
```

**Wichtige Bereiche:**

1. **Haupt-Buffer**: Hier siehst du deinen Text/Code
2. **Mode Line**: Zeigt Dateiname, Modus, Position
3. **Minibuffer**: Hier gibst du Befehle ein (die unterste Zeile)

---

## 🧠 Emacs Grundkonzepte

### 1. Buffer vs. Datei

- **Buffer** = Der Arbeitsspeicher in Emacs
  - Jede geöffnete Datei ist ein Buffer
  - Es gibt auch Buffer ohne Datei (z.B. für Suchergebnisse)
  
- **Datei** = Was auf der Festplatte gespeichert ist
  - Ein Buffer muss gespeichert werden, um zur Datei zu werden
  - Ein Buffer kann mehrere Male in verschiedenen Fenstern offen sein

**Beispiel:**
```
Du öffnest "main.cpp"
  → Emacs erstellt einen Buffer "main.cpp"
  → Du bearbeitest im Buffer
  → Änderungen sind zunächst nur im Buffer
  → Mit "Speichern" schreibst du den Buffer in die Datei
```

### 2. Fenster (Windows)

- Ein Emacs-Fenster ist ein **Bereich im Emacs-Frame**
- Du kannst viele Fenster gleichzeitig haben
- Jedes Fenster zeigt einen Buffer

```
┌──────────────┬──────────────┐
│              │              │
│   Buffer 1   │   Buffer 2   │ ← 2 Fenster nebeneinander
│   (main.cpp) │   (test.py)  │
│              │              │
└──────────────┴──────────────┘
```

### 3. Modi (Modes)

Emacs hat für jeden Dateityp einen speziellen Modus:

- **Major Mode**: Definiert das Hauptverhalten (z.B. `c++-mode`, `python-mode`)
- **Minor Modes**: Zusätzliche Features (z.B. `lsp-mode`, `company-mode`)

**Automatisch aktiv:**
- Öffnest du eine `.cpp` Datei → `c++-mode` wird aktiviert
- Öffnest du eine `.py` Datei → `python-mode` wird aktiviert

### 4. Tastatur-Notation

Emacs verwendet eine spezielle Notation für Tastenkombinationen:

| Notation | Bedeutung | Taste auf Tastatur |
|----------|-----------|-------------------|
| `C-x` | Control + X | Strg + X |
| `M-x` | Meta + X | Alt + X |
| `S-x` | Shift + X | Umschalt + X |
| `C-x C-f` | Control + X, dann Control + F | Strg+X loslassen, dann Strg+F |

**Wichtig:** Bei Kombinationen wie `C-x C-f`:
1. Drücke `Strg + X`
2. Lasse beide Tasten los
3. Drücke `Strg + F`

---

## ⌨️ Die wichtigsten Tastaturbefehle

### Die Notfall-Taste

```
╔═══════════════════════════════════════════╗
║   C-g  (Strg + G)  =  ABBRECHEN          ║
║   Die wichtigste Taste in Emacs!          ║
╚═══════════════════════════════════════════╝
```

**Wann `C-g` benutzen:**
- Emacs wartet auf Input und du willst abbrechen
- Du hast einen falschen Befehl angefangen
- Irgendwas fühlt sich "weird" an
- **Im Zweifel: Mehrmals `C-g` drücken!**

### Absolutes Minimum (Tag 1)

Diese 10 Befehle musst du kennen:

| Befehl | Beschreibung | Merkhilfe |
|--------|--------------|-----------|
| `C-x C-f` | Datei öffnen | **F**ile find |
| `C-x C-s` | Datei speichern | **S**ave |
| `C-x C-w` | Speichern unter | **W**rite |
| `C-x C-c` | Emacs beenden | **C**lose |
| `C-g` | Abbrechen | **G** wie "Go away" |
| `C-x b` | Buffer wechseln | **B**uffer |
| `C-/` oder `C-x u` | Rückgängig (Undo) | **U**ndo |
| `C-s` | Suchen vorwärts | **S**earch |
| `M-x` | Befehl ausführen | e**X**ecute |
| `C-h k` | "Was macht diese Taste?" | **H**elp **K**ey |

### Tägliche Arbeit (Tag 2-7)

**Navigation:**

| Befehl | Beschreibung | Alternative |
|--------|--------------|-------------|
| `C-f` | Ein Zeichen vorwärts | Pfeil rechts |
| `C-b` | Ein Zeichen zurück | Pfeil links |
| `C-n` | Eine Zeile runter | Pfeil runter |
| `C-p` | Eine Zeile hoch | Pfeil hoch |
| `C-a` | Zeilenanfang | Pos1 |
| `C-e` | Zeilenende | Ende |
| `M-f` | Ein Wort vorwärts | Strg+Pfeil rechts |
| `M-b` | Ein Wort zurück | Strg+Pfeil links |
| `M-<` | Datei-Anfang | Strg+Pos1 |
| `M->` | Datei-Ende | Strg+Ende |
| `C-l` | Bildschirm zentrieren | - |

**Text-Bearbeitung:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-space` | Markierung starten (Selection) |
| `C-w` | Markierten Text ausschneiden (Cut) |
| `M-w` | Markierten Text kopieren (Copy) |
| `C-y` | Text einfügen (Paste/Yank) |
| `M-y` | Durch Paste-History blättern |
| `C-k` | Rest der Zeile löschen (Kill) |
| `M-d` | Wort löschen |
| `C-d` | Zeichen löschen (Delete) |
| `M-;` | Zeile kommentieren/entkommentieren |

**Suchen & Ersetzen:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-s` | Interaktive Suche vorwärts |
| `C-r` | Interaktive Suche rückwärts |
| `M-%` | Suchen und Ersetzen (Query-Replace) |
| `C-c p s g` | In ganzen Projekt suchen (ripgrep) |

---

## 📂 Arbeiten mit Dateien

### Datei öffnen

**Grundlegender Workflow:**

1. Drücke `C-x C-f`
2. Minibuffer zeigt: `Find file: ~/`
3. Tippe den Dateinamen (Fuzzy-Search aktiv!)
4. Drücke `Enter`

**Beispiel:**
```
C-x C-f               → Find file: ~/
Tippe: main           → Zeigt: main.cpp, main.h, README.md, ...
Pfeiltasten/C-n/C-p   → Auswahl bewegen
Enter                 → Datei öffnen
```

**Fuzzy Search:**
Du musst nicht den exakten Pfad kennen:
- Tippe: `mcpp` → Findet "main.cpp"
- Tippe: `tml` → Findet "test_module.py"

**Tipps:**
- `TAB`: Vervollständigen
- `C-j`: Direktes Auswählen
- `C-g`: Abbrechen

### Datei speichern

| Befehl | Beschreibung |
|--------|--------------|
| `C-x C-s` | Aktuellen Buffer speichern |
| `C-x s` | Alle geänderten Buffer speichern |
| `C-x C-w` | Speichern unter (Write) |

**Auto-Save:**
Emacs speichert automatisch temporäre Versionen:
- Auto-Save-Datei: `#dateiname#`
- Bei Absturz: Datei aus Auto-Save wiederherstellen

### Neue Datei erstellen

**Methode 1 - Direkt öffnen:**
```
C-x C-f
Tippe: neu_datei.cpp
Enter
→ Buffer wird erstellt
C-x C-s
→ Datei wird gespeichert
```

**Methode 2 - Im Projekt:**
```
C-c p f              (Projectile: Find file)
Tippe: neu_datei.cpp
Enter (auch wenn nicht existiert)
C-x C-s
→ Datei im Projekt-Verzeichnis erstellt
```

### Datei schließen

| Befehl | Beschreibung |
|--------|--------------|
| `C-x k` | Aktuellen Buffer schließen |
| `C-x C-c` | Emacs beenden (fragt nach ungespeicherten Änderungen) |

---

## ✏️ Text bearbeiten

### Markieren (Selection)

**Grundprinzip:**
1. Bewege Cursor zum Start
2. Drücke `C-space` (Markierung aktiv)
3. Bewege Cursor zum Ende
4. Text ist markiert (highlighted)

**Beispiel:**
```cpp
// Cursor hier: [i]nt main() {
C-space                    // Markierung starten
C-e                        // Zum Zeilenende
C-w                        // Zeile ausschneiden
```

**Erweiterte Markierungen:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-x h` | Ganzen Buffer markieren |
| `M-h` | Absatz markieren |
| `C-M-space` | S-Expression markieren (für Code) |
| `C-u C-space` | Zur vorherigen Markierung springen |

### Kopieren, Ausschneiden, Einfügen

**Standard-Workflow:**
```
1. Text markieren (C-space + Bewegung)
2. Kopieren (M-w) oder Ausschneiden (C-w)
3. Cursor bewegen
4. Einfügen (C-y)
```

**Kill Ring (Clipboard-History):**
Emacs speichert die letzten 60 Kopien/Schnitte:

```
Text1 ausschneiden (C-w)
Text2 ausschneiden (C-w)
Text3 ausschneiden (C-w)

C-y           → Fügt Text3 ein
M-y           → Ersetzt durch Text2
M-y           → Ersetzt durch Text1
M-y           → Wieder Text3
```

### Löschen

| Befehl | Was wird gelöscht | Geht in Kill Ring? |
|--------|-------------------|-------------------|
| `C-d` | Zeichen unter Cursor | Nein |
| `DEL` | Zeichen vor Cursor | Nein |
| `C-k` | Vom Cursor bis Zeilenende | Ja |
| `M-d` | Wort nach Cursor | Ja |
| `M-DEL` | Wort vor Cursor | Ja |
| `C-w` | Markierter Text | Ja |

**Tipp:** Mehrmaliges `C-k` sammelt alle Zeilen im Kill Ring!

### Undo / Redo

**Undo:**
- `C-/` oder `C-x u`: Rückgängig machen
- Emacs hat **unendliches Undo**!
- Undo ist nicht linear, sondern ein Baum

**Redo:**
- Es gibt kein explizites Redo
- Stattdessen: Etwas anders machen (z.B. Cursor bewegen), dann weiter Undo
- Oder Package installieren: `undo-tree`

### Suchen & Ersetzen

**Interaktive Suche (`C-s`):**
```
C-s                    → Suche starten
Tippe: "test"         → Springt zum ersten "test"
C-s                    → Nächstes "test"
C-s                    → Noch ein "test"
C-r                    → Vorheriges "test"
Enter oder C-g        → Suche beenden
```

**Suchen & Ersetzen (`M-%`):**
```
M-%                    → Query Replace
From: test            → Was suchen?
To: demo              → Wodurch ersetzen?

Für jedes Vorkommen:
  y = Ja, ersetzen
  n = Nein, überspringen
  ! = Alle restlichen ersetzen
  q = Abbrechen
```

**Im ganzen Projekt suchen:**
```
C-c p s g             → Projectile search (mit ripgrep)
Tippe: "TODO"         → Sucht in allen Dateien
Enter                 → Ergebnisliste
C-n/C-p               → Durch Ergebnisse
Enter                 → Zu Fundstelle springen
```

### Einrückung & Formatierung

**Automatische Einrückung:**

| Befehl | Beschreibung |
|--------|--------------|
| `TAB` | Aktuelle Zeile einrücken |
| `C-M-\` | Markierte Region einrücken |
| `C-x h C-M-\` | Ganzen Buffer einrücken |

**Code formatieren (mit LSP):**
```
C-c l = =             → Formatiert Buffer/Region
                        (nutzt clang-format für C++, black für Python)
```

### Kommentare

| Befehl | Beschreibung |
|--------|--------------|
| `M-;` | Kommentar toggle (ein/aus) |
| `C-x C-;` | Auskommentieren (nur aus) |

**Beispiel:**
```cpp
// Cursor in dieser Zeile
int main() {
    return 0;
}

M-;  → // int main() {

M-;  → int main() {   (wieder zurück)
```

---

## 🪟 Fenster & Buffer Management

### Fenster (Windows)

Emacs kann mehrere Fenster **gleichzeitig** anzeigen:

**Fenster teilen:**

| Befehl | Beschreibung | Visual |
|--------|--------------|--------|
| `C-x 2` | Horizontal teilen | `[Buffer1]`<br>`─────────`<br>`[Buffer2]` |
| `C-x 3` | Vertikal teilen | `[Buffer1] │ [Buffer2]` |
| `C-x 1` | Nur aktuelles Fenster | `[Buffer1]` (andere schließen) |
| `C-x 0` | Aktuelles Fenster schließen | Fenster verschwindet |
| `C-x o` | Zum anderen Fenster | Wechselt Focus |
| `C-x 4 f` | Datei in anderem Fenster öffnen | |

**Typischer Workflow:**
```
Start:
┌─────────────────────┐
│    main.cpp         │
│                     │
└─────────────────────┘

C-x 2  (horizontal split):
┌─────────────────────┐
│    main.cpp         │
├─────────────────────┤
│    main.cpp         │ ← gleicher Buffer!
└─────────────────────┘

C-x o  (zu unterem Fenster)
C-x C-f test.py  (andere Datei öffnen):
┌─────────────────────┐
│    main.cpp         │
├─────────────────────┤
│    test.py          │
└─────────────────────┘

C-x 3  (in unterem Fenster vertikal teilen):
┌─────────────────────┐
│    main.cpp         │
├──────────┬──────────┤
│ test.py  │ test.py  │
└──────────┴──────────┘
```

### Buffer Management

**Buffer wechseln:**

```
C-x b                 → Öffnet Buffer-Liste mit Fuzzy-Search
Tippe: "main"        → Zeigt: main.cpp, main.h, ...
Enter                → Wechselt zu Buffer
```

**Buffer-Liste anzeigen:**
```
C-x C-b              → Zeigt alle offenen Buffer
n / p                → Hoch/Runter
RET                  → Buffer öffnen
d                    → Buffer zum Löschen markieren
x                    → Markierte Buffer löschen
q                    → Buffer-Liste schließen
```

**Buffer schließen:**
```
C-x k                → Aktuellen Buffer schließen
C-x k RET            → Aktuellen Buffer direkt schließen
C-x k main.cpp RET   → Spezifischen Buffer schließen
```

**Praktische Buffer-Befehle:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-x C-b` | Buffer-Liste anzeigen |
| `C-x b` | Buffer wechseln (mit Name) |
| `C-x k` | Buffer schließen |
| `C-x C-q` | Read-only toggle |
| `M-x ibuffer` | Bessere Buffer-Liste |

### Treemacs (File Explorer)

Deine Config hat **Treemacs** - ein grafischer Datei-Explorer:

**Starten:**
```
C-x t t              → Treemacs öffnen/schließen
M-0                  → Zu Treemacs wechseln
```

**In Treemacs navigieren:**

| Taste | Beschreibung |
|-------|--------------|
| `j` / `k` oder `n` / `p` | Hoch/Runter |
| `RET` | Datei öffnen / Ordner auf/zuklappen |
| `c` | Neue Datei erstellen |
| `d` | Datei/Ordner löschen |
| `R` | Umbenennen |
| `M` | Verschieben |
| `+` | Ordner erstellen |
| `q` | Treemacs schließen |
| `?` | Hilfe anzeigen |

**Beispiel-Workflow:**
```
C-x t t              → Treemacs öffnen
j j j                → Zu "src/" navigieren
RET                  → Ordner aufklappen
j                    → Zu "main.cpp"
RET                  → Datei öffnen
M-0                  → Zurück zu Treemacs
c                    → Neue Datei
test.cpp             → Name eingeben
RET                  → Datei erstellen
```

---

## 📦 Projekt-Management mit Projectile

**Projectile** macht das Arbeiten mit großen Projekten super einfach!

### Was ist ein Projekt?

Ein Verzeichnis ist ein Projekt, wenn es eines davon enthält:
- `.git/` (Git Repository)
- `CMakeLists.txt` (CMake Projekt)
- `pyproject.toml` (Python Projekt)
- `.projectile` (Marker-Datei)

### Projekt öffnen

```
C-c p p              → Projekt auswählen
Tippe: "my-pro"      → Fuzzy-Search in Projekten
Enter                → Projekt wird "aktiv"
```

### Projekt-Befehle

Alle Projectile-Befehle starten mit `C-c p`:

**Datei-Operations:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c p f` | Datei im Projekt finden |
| `C-c p d` | Verzeichnis im Projekt finden |
| `C-c p 4 f` | Datei in anderem Fenster öffnen |
| `C-c p F` | Datei in allen bekannten Projekten finden |

**Suchen:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c p s g` | Mit ripgrep im Projekt suchen |
| `C-c p s s` | Mit Swiper im Projekt suchen |
| `C-c p r` | Suchen & Ersetzen im ganzen Projekt |

**Projekt-Management:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c p p` | Projekt wechseln |
| `C-c p c` | Projekt kompilieren |
| `C-c p P` | Projekt testen |
| `C-c p k` | Alle Projekt-Buffer schließen |
| `C-c p D` | Projekt-Root in Dired öffnen |

### Praktisches Beispiel

**Szenario:** Arbeiten an C++ Projekt

```
1. Projekt öffnen:
   C-c p p  →  Tippe "my-game"  →  Enter

2. Datei schnell finden:
   C-c p f  →  Tippe "player"  →  Enter
   → Öffnet: src/entities/player.cpp

3. Im ganzen Projekt suchen:
   C-c p s g  →  Tippe "TODO"
   → Zeigt alle TODO-Kommentare

4. Projekt bauen:
   C-c p c  →  Enter
   → Führt: cmake --build build/ aus
```

### .projectile Datei

Du kannst eine `.projectile` Datei im Projekt-Root erstellen:

```
# .projectile
# Verzeichnisse ignorieren
-/build
-/node_modules
-/.git

# Nur bestimmte Dateien indexieren
+*.cpp
+*.h
+*.py
```

---

## 🚀 Code-Entwicklung mit LSP

**LSP** (Language Server Protocol) macht Emacs zu einer vollwertigen IDE!

### Was ist LSP?

LSP bietet:
- ✅ **Auto-Completion**: Intelligente Code-Vervollständigung
- ✅ **Go to Definition**: Springe zur Funktion/Variable
- ✅ **Find References**: Finde alle Verwendungen
- ✅ **Rename**: Benenne Symbol im ganzen Projekt um
- ✅ **Error Checking**: Echtzeit-Fehlerprüfung
- ✅ **Code Actions**: Quick-Fixes
- ✅ **Formatting**: Automatische Code-Formatierung
- ✅ **Documentation**: Hover-Info

### LSP aktivieren

**Automatisch aktiv für:**
- C++ Dateien (`.cpp`, `.h`, `.hpp`)
- Python Dateien (`.py`)

**Manuell aktivieren:**
```
M-x lsp
```

**Verfügbarkeit prüfen:**
```
M-x lsp-doctor      → Zeigt fehlende Dependencies
```

### LSP Befehle

Alle LSP-Befehle beginnen mit `C-c l`:

**Navigation:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c l g g` oder `M-.` | Gehe zu Definition |
| `C-c l g r` | Finde alle Referenzen |
| `C-c l g i` | Finde Implementierung |
| `C-c l g t` | Gehe zu Type-Definition |
| `M-,` | Zurück (nach Go-to-Definition) |

**Code-Änderungen:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c l r r` | Rename Symbol |
| `C-c l = =` | Buffer/Region formatieren |
| `C-c l = r` | Nur Region formatieren |
| `C-c l a a` | Code Actions (Quick-Fixes) |
| `C-c l a o` | Organize Imports |

**Information:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c l g h` oder `K` | Hover-Info (Dokumentation) |
| `C-c l g s` | Dokumentations-Signatur |
| `C-c l f r` | Alle Referenzen im Projekt |

### Auto-Completion (Company Mode)

**Automatisch:**
```cpp
std::vec    → Popup mit Vorschlägen erscheint
            → std::vector
```

**Steuerung:**

| Taste | Beschreibung |
|-------|--------------|
| `TAB` | Auswählen & einfügen |
| `C-n` | Runter in Liste |
| `C-p` | Hoch in Liste |
| `M-1` - `M-9` | Direkt auswählen (nach Nummer) |
| `C-g` | Abbrechen |
| `M-h` | Dokumentation anzeigen |

**Completion manuell triggern:**
```
M-x company-complete
```

### Fehler & Warnungen (Flycheck)

**Automatisch:**
- Fehler werden rot unterstrichen
- Warnungen werden gelb unterstrichen

**Navigation:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c ! n` | Nächster Fehler |
| `C-c ! p` | Vorheriger Fehler |
| `C-c ! l` | Liste aller Fehler |
| `M-g n` | Next error (alternative) |
| `M-g p` | Previous error (alternative) |

### Praktisches Beispiel: C++

```cpp
// Datei: player.cpp
#include "player.h"

void Player::update() {
    // Cursor auf "update"
    // C-c l g r  →  Zeigt alle Verwendungen von update()
    
    position.x += velocity.x;
    //      ↑ Cursor hier
    // C-c l r r  →  Rename "x" zu "xPos"
    //              → Ändert in ganzer Codebase!
    
    // Cursor auf "position"
    // M-.  →  Springt zur Definition von position
    // M-,  →  Zurück zu player.cpp
}
```

---

## 🐙 Git mit Magit

**Magit** ist das beste Git-Interface der Welt! Kein Witz.

### Magit starten

```
C-x g               → Öffnet Magit Status
```

**Der Status-Buffer:**
```
Magit: my-project
Head:     main
──────────────────────────────────────
Untracked files (1)
    new_file.cpp

Unstaged changes (2)
M   src/main.cpp
M   include/player.h

Staged changes (1)
A   tests/test_player.cpp
──────────────────────────────────────
Recent commits
```

### Grundlegende Magit-Befehle

**Im Status-Buffer:**

| Taste | Beschreibung |
|-------|--------------|
| `s` | Stage file/change unter Cursor |
| `u` | Unstage file/change |
| `k` | Discard changes (Vorsicht!) |
| `c c` | Commit erstellen |
| `P p` | Push zu Remote |
| `F p` | Pull von Remote |
| `b b` | Branch wechseln |
| `b c` | Neuen Branch erstellen |
| `l l` | Commit-Log anzeigen |
| `d d` | Diff anzeigen |
| `z z` | Stash erstellen |
| `z p` | Stash pop |
| `?` | Hilfe |
| `q` | Magit schließen |
| `TAB` | Section auf/zuklappen |
| `RET` | Details anzeigen/zur Datei springen |

### Commit-Workflow

**Schritt für Schritt:**

```
1. Änderungen gemacht in main.cpp
2. C-x g                → Magit Status öffnen
3. Cursor auf "main.cpp"
4. s                    → Stage main.cpp
5. c c                  → Commit Message eingeben
6. Tippe Commit-Message
7. C-c C-c              → Commit bestätigen
8. P p                  → Push zu GitHub/GitLab
```

**Im Commit-Message-Buffer:**

| Befehl | Beschreibung |
|--------|--------------|
| `C-c C-c` | Commit abschließen |
| `C-c C-k` | Commit abbrechen |

### Branch-Management

**Branch wechseln:**
```
C-x g                → Magit öffnen
b b                  → Branch Checkout
Tippe: "feature"     → Fuzzy-Search
Enter                → Wechselt zu Branch
```

**Neuer Branch:**
```
b c                  → Branch Create
Name: feature/login  → Branch-Name
Enter                → Erstellt & wechselt
```

**Branch mergen:**
```
m m                  → Merge
Wähle Branch         → Branch auswählen
Enter                → Merge durchführen
```

### Diff anzeigen

**Cursor auf Datei:**
```
TAB                  → Diff auf/zuklappen
RET                  → Zur Datei im Code springen
```

**Hunks einzeln stagen:**
```
Cursor auf spezifische Änderung (Hunk)
s                    → Nur dieser Hunk wird gestaged
```

### Log anzeigen

```
l l                  → Commit-Log
n / p                → Hoch/Runter
RET                  → Commit-Details
q                    → Log schließen
```

**Filter:**
```
l r                  → Log für aktuellen Branch
l o                  → Log für anderen Branch
l f                  → Log für Datei
```

### Konflikte lösen

**Bei Merge-Konflikt:**

```
1. C-x g               → Magit öffnen
2. Status zeigt "Unmerged"
3. RET auf Konflikt-Datei
4. Ediff öffnet sich mit 3 Panels:
   - A: Deine Version
   - B: Ihre Version  
   - C: Merge-Result

5. Im Ediff:
   a = Nehme A
   b = Nehme B
   q = Ediff beenden

6. Zurück in Magit:
   s = Stage resolved file
   c c = Commit merge
```

### Git-Befehle ausführen

```
! !                  → Beliebigen Git-Befehl ausführen
Tippe: reset --hard HEAD~1
Enter                → Führt aus
```

---

## 🔧 C++ Development

### LSP für C++ einrichten

**clangd muss installiert sein:**

```cmd
# Prüfen ob clangd installiert ist:
clangd --version

# Falls nicht installiert:
# Download von: https://clangd.llvm.org/installation
```

**compile_commands.json generieren:**

Für intelligente Code-Completion braucht clangd `compile_commands.json`:

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.10)
project(MyProject)

# WICHTIG: Diese Zeile hinzufügen!
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(main main.cpp)
```

```bash
# Bauen
cmake -B build
cmake --build build

# compile_commands.json wird in build/ erstellt
# Symlink im Root:
# Linux/Mac:
ln -s build/compile_commands.json .
# Windows:
mklink compile_commands.json build\compile_commands.json
```

### C++ Projekt-Struktur

```
my-cpp-project/
├── CMakeLists.txt
├── compile_commands.json  ← Symlink
├── .clang-format          ← Code-Style
├── src/
│   ├── main.cpp
│   ├── player.cpp
│   └── enemy.cpp
├── include/
│   ├── player.h
│   └── enemy.h
├── tests/
│   └── test_player.cpp
└── build/                 ← Build-Output
```

### C++ Workflow

**1. Projekt erstellen:**

```bash
mkdir my-game
cd my-game
```

**CMakeLists.txt:**
```cmake
cmake_minimum_required(VERSION 3.15)
project(MyGame)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include_directories(include)

add_executable(game
    src/main.cpp
    src/player.cpp
)
```

**2. Code schreiben:**

```bash
emacs .              → Öffnet Projekt
```

In Emacs:
```
C-c p f              → Find file
src/main.cpp         → Erstellen

# main.cpp schreiben:
```

```cpp
#include <iostream>
#include "player.h"

int main() {
    Player player("Hero");
    player.greet();
    return 0;
}
```

**3. Header erstellen:**

```
C-c p f
include/player.h
```

```cpp
#ifndef PLAYER_H
#define PLAYER_H

#include <string>

class Player {
private:
    std::string mName;  // m prefix from your preferences

public:
    Player(const std::string& aName);  // a prefix for parameters
    void greet();
};

#endif
```

**4. Implementation:**

```cpp
// src/player.cpp
#include "player.h"
#include <iostream>

Player::Player(const std::string& aName) : mName(aName) {
    // Local variables: l prefix
    int lInitHealth = 100;
}

void greet() {
    std::cout << "Hello, I'm " << mName << std::endl;
}
```

**5. Bauen:**

```
C-c p c              → Compile
cmake -B build && cmake --build build
Enter

# Oder eigenen Befehl definieren:
M-x compile
cmake -B build && cmake --build build
```

**6. Ausführen:**

```
M-x shell            → Shell in Emacs
./build/game
```

### C++ LSP Features

**Auto-Completion:**
```cpp
std::v               → std::vector<
                        ↑ Automatisches Popup mit allen std::v* Funktionen
```

**Include automatisch hinzufügen:**
```cpp
Player player;       ← Fehler: Player nicht deklariert
C-c l a a           → Code Actions
                     → "Add #include "player.h""
```

**Refactoring:**
```cpp
class Player {
    int health;      ← Cursor hier
};

C-c l r r            → Rename
mHealth              → Neuer Name
Enter                → Überall umbenannt!
```

**Navigation:**
```cpp
player.greet();      ← Cursor auf "greet"
M-.                  → Springt zu Definition in player.cpp
M-,                  → Zurück zu main.cpp
```

### .clang-format

Code-Style definieren:

```yaml
# .clang-format
BasedOnStyle: Google
IndentWidth: 4
ColumnLimit: 100
```

Dann:
```
C-c l = =            → Formatiert ganzen Buffer
```

---

## 🐍 Python Development

### Python LSP einrichten

**Python LSP Server installieren:**

```cmd
python -m pip install python-lsp-server[all] black isort
```

**Prüfen:**
```cmd
python -m pip list | findstr lsp
```

### Python Projekt-Struktur

```
my-python-project/
├── pyproject.toml   oder   requirements.txt
├── src/
│   ├── __init__.py
│   ├── main.py
│   └── utils.py
├── tests/
│   └── test_utils.py
└── .venv/           ← Virtual Environment
```

### Python Workflow

**1. Projekt erstellen:**

```bash
mkdir my-app
cd my-app
python -m venv .venv
```

**2. In Emacs öffnen:**

```bash
emacs .
```

**3. Virtual Environment aktivieren:**

```
M-x pyvenv-activate
.venv/                → Enter
```

**4. Code schreiben:**

```
C-c p f
src/main.py
```

```python
def greet(name: str) -> str:
    """Greet someone with a message."""
    return f"Hello, {name}!"

if __name__ == "__main__":
    message = greet("Emacs")
    print(message)
```

**Auto-Save formatiert mit Black!**

**5. Code ausführen:**

```
C-c C-c              → Code ausführen
```

**Oder Python REPL:**
```
C-c C-z              → Python REPL öffnen
C-c C-c              → Code in REPL senden
```

### Python LSP Features

**Type Hints:**
```python
def add(a: int, b: int) -> int:
    return a + b

result = add(1, 2)  # LSP zeigt: result: int
```

**Auto-Imports:**
```python
pd.DataFrame()       ← Fehler: pandas nicht importiert
C-c l a a           → Code Actions
                     → "Import pandas as pd"
```

**Documentation:**
```python
greet("World")
#     ↑ Cursor hier
K                    → Zeigt Docstring
```

### Python Testing

**pytest integrieren:**

```python
# tests/test_utils.py
def test_greet():
    from main import greet
    assert greet("Test") == "Hello, Test!"
```

**In Emacs:**
```
M-x python-pytest
tests/               → Enter
```

---

## ⚙️ Emacs anpassen

### Config-Datei

**Speicherort:**
```
Windows: C:\Users\DEIN_NAME\AppData\Roaming\.emacs.d\init.el
Linux/Mac: ~/.emacs.d/init.el
```

**Config öffnen:**
```
C-x C-f
~/.emacs.d/init.el
Enter
```

**Config neu laden:**
```
M-x eval-buffer      → Lädt ganze Datei neu
C-x C-e              → Führt Ausdruck vor Cursor aus
```

### Theme ändern

**Verfügbare Doom-Themes:**
```elisp
;; In init.el:
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))  ; Standard

  ;; Alternativen:
  ;; (load-theme 'doom-dracula t)
  ;; (load-theme 'doom-molokai t)
  ;; (load-theme 'doom-nord t)
  ;; (load-theme 'doom-tomorrow-night t)
```

**Theme interaktiv wechseln:**
```
M-x load-theme
doom-dracula         → Auswählen
```

### Schriftart ändern

```elisp
;; init.el
(set-face-attribute 'default nil 
                    :family "Consolas"  ; oder "Cascadia Code", "Fira Code"
                    :height 120)        ; Größe (120 = 12pt)
```

### Eigene Keybindings

```elisp
;; Globale Keybinding
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; Nur für bestimmten Mode
(add-hook 'c++-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c b") 'compile)))
```

**Beispiel-Bindings:**
```elisp
;; Schneller speichern
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-f") 'swiper)  ; C-f für Suche

;; Fenster-Navigation mit Alt+Pfeiltasten
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)
```

### Weitere nützliche Anpassungen

```elisp
;; Automatisches Schließen von Klammern
(electric-pair-mode 1)

;; Smooth Scrolling
(setq scroll-margin 3
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;; Line wrapping
(global-visual-line-mode 1)

;; Auto-Refresh von Dateien
(global-auto-revert-mode 1)

;; Backup-Dateien in eigenem Ordner
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Recent Files
(recentf-mode 1)
(setq recentf-max-saved-items 50)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
```

### Packages manuell installieren

```
M-x package-list-packages
```

Im Package-Buffer:
- `i` = Zum Installieren markieren
- `d` = Zum Löschen markieren
- `x` = Ausführen
- `/` = Filtern
- `q` = Schließen

**Direkt installieren:**
```
M-x package-install RET package-name
```

**Nützliche Packages:**
- `undo-tree`: Besseres Undo-System
- `yasnippet`: Code-Snippets
- `rainbow-delimiters`: Farbige Klammern
- `highlight-indent-guides`: Einrückung visualisieren
- `all-the-icons`: Icons für verschiedene Modi

---

## 💡 Tipps & Tricks

### 1. Hilfe-System meistern

Das Hilfe-System ist dein bester Freund:

| Befehl | Beschreibung |
|--------|--------------|
| `C-h k` | "Was macht diese Taste?" |
| `C-h f` | Funktion-Dokumentation |
| `C-h v` | Variable-Dokumentation |
| `C-h m` | Aktuelle Modi-Hilfe |
| `C-h a` | Apropos (Suche nach Befehlen) |
| `C-h i` | Info-Manual öffnen |
| `C-h t` | Emacs-Tutorial |

**Beispiel:**
```
Du weißt nicht mehr was C-x 3 macht:
C-h k         → "Describe key:"
C-x 3         → Zeigt: "split-window-right - Split window horizontally"
```

### 2. Befehle mit M-x finden

`M-x` ist magisch - es findet alles:

```
M-x com...       → Zeigt: company-mode, compile, comment-region, ...
M-x buff...      → Zeigt: buffer-menu, bury-buffer, ...
```

**Tipps:**
- Fuzzy-Matching: `M-x cmnrg` findet `comment-region`
- History: `M-p` / `M-n` durch vorherige Befehle

### 3. Multiple Cursors

**Scenario:** Gleiche Änderung an vielen Stellen:

```cpp
int x = 10;
int y = 20;
int z = 30;

// Alle "int" zu "float" ändern:
1. Markiere "int" im ersten
2. C->  C->  C->        → Markiert alle "int"
3. Tippe "float"        → Ändert alle gleichzeitig!
```

**Befehle:**
- `C->`: Nächstes "like-this" markieren
- `C-<`: Vorheriges "like-this"
- `C-c C-<`: Alle "like-this" markieren

### 4. Bookmarks

Wichtige Dateien als Bookmark speichern:

```
C-x r m          → Bookmark setzen
my-bookmark      → Name eingeben

C-x r b          → Zu Bookmark springen
my-bookmark      → Auswählen
```

**Bookmark-Liste:**
```
M-x bookmark-bmenu-list
```

### 5. Registers

Textstellen oder Positionen speichern:

```
C-x r SPC a      → Position in Register 'a' speichern
C-x r j a        → Zu Register 'a' springen

C-x r s a        → Text in Register 'a' speichern
C-x r i a        → Text aus Register 'a' einfügen
```

### 6. Macros aufnehmen

Wiederkehrende Aufgaben automatisieren:

```
C-x (            → Macro-Aufnahme starten
... Aktionen durchführen ...
C-x )            → Macro-Aufnahme beenden
C-x e            → Macro ausführen
C-u 10 C-x e     → Macro 10x ausführen
```

**Beispiel:**
```
Zeilen formatieren:
C-x (                    → Start
C-a                      → Zeilenanfang
Tippe "- "              → Listenzeichen
C-n                      → Nächste Zeile
C-x )                    → Ende

C-u 20 C-x e            → 20 Zeilen formatieren
```

### 7. Shell in Emacs

```
M-x shell        → Normale Shell
M-x eshell       → Emacs-eigene Shell
M-x term         → Terminal-Emulator
```

**In Shell:**
- `C-c C-c`: Prozess abbrechen (statt Strg+C)
- `C-c C-o`: Letzte Output löschen
- Normale Emacs-Befehle funktionieren!

### 8. Tabs/Spaces einstellen

```elisp
;; init.el
(setq-default indent-tabs-mode nil)  ; Spaces statt Tabs
(setq-default tab-width 4)            ; Tab-Breite = 4
(setq c-basic-offset 4)               ; C/C++ Einrückung = 4
```

### 9. Performance-Tricks

```elisp
;; init.el - Am Anfang
(setq gc-cons-threshold 100000000)     ; Garbage Collection seltener
(setq read-process-output-max (* 1024 1024))  ; Mehr Output von LSP

;; Am Ende
(setq gc-cons-threshold 800000)        ; Wieder normalisieren
```

### 10. Dired (Directory Editor)

Datei-Manager in Emacs:

```
C-x d            → Dired öffnen

Im Dired:
RET              → Datei öffnen / In Ordner gehen
^                → Übergeordneter Ordner
m                → Datei markieren
u                → Markierung entfernen
d                → Zum Löschen markieren
x                → Markierte Dateien löschen
C                → Kopieren
R                → Umbenennen/Verschieben
+                → Neuer Ordner
Z                → Komprimieren
g                → Aktualisieren
```

---

## 🆘 Troubleshooting

### Emacs startet nicht / stürzt ab

**1. Config-Problem:**
```bash
# Emacs ohne Config starten:
emacs -q

# Wenn das funktioniert:
# Config schrittweise testen:
emacs --debug-init
```

**2. Package-Problem:**
```elisp
M-x package-refresh-contents
M-x package-install-selected-packages
```

**3. Korrupte Packages:**
```bash
# Alle Packages löschen und neu installieren:
# Schließe Emacs
rm -rf ~/.emacs.d/elpa/
# Starte Emacs → Packages werden neu geladen
```

### LSP startet nicht

**1. Diagnose:**
```
M-x lsp-doctor
```

**2. LSP neu starten:**
```
M-x lsp-workspace-restart
```

**3. Python-LSP:**
```cmd
python -m pip install --upgrade python-lsp-server[all]
```

**4. C++ clangd:**
```cmd
# Prüfen ob installiert:
clangd --version

# Falls nicht, Download von:
https://clangd.llvm.org/installation.html
```

### Emacs ist langsam

**1. LSP deaktivieren:**
```
M-x lsp-disconnect
```

**2. Line numbers ausschalten:**
```
M-x global-display-line-numbers-mode
```

**3. Große Dateien:**
```elisp
;; init.el
(setq large-file-warning-threshold 100000000)  ; 100MB
```

### Keybinding funktioniert nicht

**1. Prüfen ob Keybinding belegt:**
```
C-h k C-c C-c    → Zeigt was C-c C-c macht
```

**2. Im welchem Modus bist du?**
```
C-h m            → Zeigt alle Modi-Keybindings
```

**3. Eigenes Keybinding überschreibt anderes:**
```elisp
;; Prüfe Reihenfolge in init.el
;; Later definitions override earlier ones
```

### Encoding-Probleme (Umlaute)

```elisp
;; init.el
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
```

### Git/Magit funktioniert nicht

**1. Git prüfen:**
```cmd
git --version
where git
```

**2. Magit neu laden:**
```
M-x magit-refresh
```

**3. Credentials:**
```cmd
# Git Credentials speichern:
git config --global credential.helper manager
```

### Packages installieren scheitert

**1. Repository aktualisieren:**
```
M-x package-refresh-contents
```

**2. HTTPS-Probleme:**
```elisp
;; init.el - Alternative URLs:
(setq package-archives 
  '(("melpa" . "http://melpa.org/packages/")
    ("gnu" . "http://elpa.gnu.org/packages/")))
```

**3. Proxy-Einstellungen:**
```elisp
;; Falls hinter Proxy:
(setq url-proxy-services
   '(("http" . "proxy.example.com:8080")
     ("https" . "proxy.example.com:8080")))
```

### Company-Mode completion zeigt nichts

**1. Company aktivieren:**
```
M-x company-mode
```

**2. Backend prüfen:**
```
M-x company-diag
```

**3. Manuell triggern:**
```
M-x company-complete
```

### Terminal-Farben falsch

```elisp
;; init.el
(setq frame-background-mode 'dark)  ; oder 'light
```

---

## 📚 Weitere Ressourcen

### Offizielle Dokumentation

- **Emacs Manual**: `C-h r` oder https://www.gnu.org/software/emacs/manual/
- **Emacs Tutorial**: `C-h t`
- **Emacs Wiki**: https://www.emacswiki.org/

### Lernen

- **Mastering Emacs**: https://www.masteringemacs.org/
  - Beste Emacs-Ressource!
  
- **Emacs Rocks**: http://emacsrocks.com/
  - Video-Tutorials
  
- **Emacs Reference Card**: https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf
  - Zum Ausdrucken

### Spezifische Tools

- **LSP Mode**: https://emacs-lsp.github.io/lsp-mode/
- **Magit**: https://magit.vc/
- **Projectile**: https://docs.projectile.mx/
- **Company**: https://company-mode.github.io/

### Community

- **r/emacs**: https://www.reddit.com/r/emacs/
- **Emacs Stack Exchange**: https://emacs.stackexchange.com/
- **Discord**: Emacs Server

---

## 🎓 Lernplan: Erste 30 Tage

### Woche 1: Grundlagen

**Tag 1-2: Navigation & Basics**
- [ ] `C-x C-f`, `C-x C-s`, `C-x C-c`
- [ ] `C-f`, `C-b`, `C-n`, `C-p`
- [ ] `C-a`, `C-e`
- [ ] `C-g` (Notfall!)

**Tag 3-4: Editing**
- [ ] `C-space`, `C-w`, `M-w`, `C-y`
- [ ] `C-k`, `C-/`
- [ ] `C-s` (Suchen)

**Tag 5-7: Windows & Buffers**
- [ ] `C-x 2`, `C-x 3`, `C-x o`
- [ ] `C-x b`, `C-x k`
- [ ] `C-x 1`

### Woche 2: Produktivität

**Tag 8-10: Projectile**
- [ ] `C-c p p` (Projekt wechseln)
- [ ] `C-c p f` (Datei finden)
- [ ] `C-c p s g` (Im Projekt suchen)

**Tag 11-13: LSP**
- [ ] `M-.` (Go to Definition)
- [ ] `C-c l g r` (Find References)
- [ ] `C-c l r r` (Rename)
- [ ] Auto-Completion nutzen

**Tag 14: Review**
- [ ] Eigenes kleines Projekt starten
- [ ] Alle gelernten Befehle anwenden

### Woche 3: Advanced

**Tag 15-17: Git/Magit**
- [ ] `C-x g` (Magit Status)
- [ ] `s`, `u`, `c c` (Stage, Unstage, Commit)
- [ ] `P p` (Push)

**Tag 18-20: Customization**
- [ ] Config öffnen und verstehen
- [ ] Theme ändern
- [ ] Eigenes Keybinding hinzufügen

**Tag 21: Master-Projekt**
- [ ] Komplettes Projekt von Grund auf
- [ ] Git-Workflow
- [ ] LSP-Features nutzen

### Woche 4: Spezialisierung

**Tag 22-30:**
- [ ] Deep-Dive in deinen Haupt-Language (C++ oder Python)
- [ ] Fortgeschrittene Magit-Features
- [ ] Eigene Packages installieren
- [ ] Emacs in tägliche Workflow integrieren

---

## 🏁 Zusammenfassung

### Die wichtigsten 20 Befehle

```
┌─────────────────────────────────────────────┐
│  EMACS TOP 20 - Das MUSST du kennen!       │
├─────────────────────────────────────────────┤
│  1. C-g         → Abbrechen (IMMER!)       │
│  2. C-x C-f     → Datei öffnen             │
│  3. C-x C-s     → Speichern                 │
│  4. C-x C-c     → Beenden                   │
│  5. C-/         → Undo                      │
│  6. C-x b       → Buffer wechseln           │
│  7. C-x 2       → Split horizontal          │
│  8. C-x o       → Fenster wechseln          │
│  9. C-space     → Markierung starten        │
│ 10. C-w/M-w     → Cut/Copy                  │
│ 11. C-y         → Paste                     │
│ 12. C-s         → Suchen                    │
│ 13. M-x         → Befehl ausführen          │
│ 14. C-c p p     → Projekt wechseln          │
│ 15. C-c p f     → Datei im Projekt finden   │
│ 16. M-.         → Zu Definition             │
│ 17. C-c l r r   → Rename                    │
│ 18. C-x g       → Git Status (Magit)        │
│ 19. C-h k       → Was macht diese Taste?    │
│ 20. C-c p s g   → Im Projekt suchen         │
└─────────────────────────────────────────────┘
```

### Schnellstart-Checkliste

- [ ] `install.bat` ausgeführt
- [ ] Terminal neu gestartet
- [ ] `emacs` funktioniert
- [ ] Packages wurden geladen (beim ersten Start)
- [ ] LSP funktioniert (in .cpp und .py Dateien testen)
- [ ] Magit funktioniert (`C-x g`)
- [ ] Projectile erkennt deine Projekte
- [ ] Diese Anleitung ausgedruckt/gebookmarkt

---

**🎉 Herzlichen Glückwunsch! Du bist jetzt bereit für Emacs!**

Bei Fragen:
1. Drücke `C-h k` + Tastenkombination
2. Nutze `M-x` + Suchbegriff
3. Schaue in diese Anleitung
4. Googel: "emacs wie mache ich X"

**Remember:** Nach 2 Wochen harter Arbeit wirst du produktiver sein als je zuvor. Emacs ist die Investition wert! 🚀

---

*Stand: Dezember 2024*
*Für Emacs 29.1+ mit LSP, Projectile, Magit*
