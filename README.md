# Hauptseminararbeit: Genauigkeit automatisierter Zählungen des Fuß- und Radverkehrs

Dieses Repository enthält Skripte und Daten für die Hauptseminararbeit zur Genauigkeit automatisierter Zählungen des Rad- und Fußverkehrs. Teile dieser Dokumentation wurden mithilfe von ChatGPT erstellt.

## Struktur des Repositorys

Das Repository ist folgendermaßen strukturiert:

- `.vscode`: Enthält Konfigurationen für den Editor Visual Studio Code.
- `auswertung_output`: Speichert Ausgabedateien, generiert durch die Auswertungsskripte.
- `binaererklassifikator`: Enthält das Skript für den Binärklassifikator und zugehörige Dateien.
- `data`: Beinhaltet die im Projekt verwendeten Daten.
- `plots`: Speichert die generierten Plots.
- `Auswertung.Rproj`: R-Projekt-Datei.
- `README.md`: Bietet eine Übersicht über das Repository und Anleitungen zur Nutzung der Skripte.
- `auswertung.ipynb`: Jupyter-Notebook-Datei mit Auswertungsskript.
- `ganglinienplot.R`: R-Skript zur Erzeugung von Liniendiagrammen.
- `merge.R`: R-Skript zur Zusammenführung mehrerer Datendateien.
- `plot.R`: R-Skript zur Erzeugung diverser Plots.
- `referenzdaten_fehlerplot.R`: R-Skript zur Erstellung von Fehlerdiagrammen auf Basis von Referenzdaten.
- `referenzdaten_fehleruntersuchung.ipynb`: Jupyter-Notebook-Datei mit Skript zur Fehleruntersuchung in Referenzdaten.
- `schnittpunkt_plot.R`: R-Skript zur Erstellung eines Plots, der potenzielle Fehler veranschaulicht.

## Skripte

### auswertung.ipynb

Dieses Python-Skript liest und zählt Klassen in zwei Ereignislisten im CSV-Format. Die Ergebnisse werden in separaten Tabellen für jeden Zählquerschnitt und jede Zählklasse ausgegeben.

### referenzdaten_fehleruntersuchung.ipynb

Mit diesem Skript werden zwei Referenzzählungen verglichen und mögliche Abweichungen ermittelt, um potenzielle Fehler zu identifizieren.

### referenzdaten_fehleranalyse.R

Dieses Skript liest die Ausgabedaten von `auswertung.ipynb`, berechnet die Fehler zwischen zwei Referenzzählungen und gibt die Ergebnisse in einer PDF-Tabelle aus.

### merge.R

Mit `merge.R` werden die generierten Tabellen zusammengeführt.

### plot.R

Dieses Skript visualisiert die Daten aus `auswertung.ipynb`, indem es verschiedene Plots erstellt.

## Python-Abhängigkeiten

* pandas
* numpy
* seaborn
* matplotlib
* re
* datetime

## R-Voraussetzungen

* R (Version 3.6.0 oder höher)
* R-Pakete: `tidyverse`, `lubridate`
