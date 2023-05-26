# Hauptseminararbeit: Genauigkeit automatisierter Zahlungen des Fuß- und Radverkehrs

Dieses Repository enthält Skripte und Daten für Hauptseminararbeit zur Genauigkeit automatisierter Zahlungen des Rad- und Fußverkehrs.
Diese Dokumentation ist in teilen mit Hilfe von ChatGPT entstanden.

## Struktur des Repositorys

Das Repository ist wie folgt organisiert:

- `.vscode`: Dieses Verzeichnis enthält Einstellungen für den Editor Visual Studio Code.
- `auswertung_output`: In diesem Verzeichnis werden Ausgabedateien gespeichert, die von den Auswertungsskripten erstellt werden.
- `binaererklassifikator`: Dieses Verzeichnis enthält das Skript für den Binärklassifikator und zugehörige Dateien.
- `data`: In diesem Verzeichnis befinden sich die Daten, die im Projekt verwendet werden.
- `plots`: Dieses Verzeichnis enthält erzeugte Plot-Dateien.
- `Auswertung.Rproj`: Dies ist die Datei für das R-Projekt.
- `README.md`: Diese Datei bietet einen Überblick über das Repository und Anleitungen zur Verwendung der Skripte.
- `auswertung.ipynb`: Dies ist eine Jupyter-Notebook-Datei, die das Auswertungsskript zur Vorfilterung enthält.
- `ganglinienplot.R`: Dieses R-Skript erzeugt feine Ganlinien, wurde aber letzendlich nicht für die Untersuchung verwendet.
- `merge.R`: Dieses R-Skript führt mehrere Datendateien zusammen.
- `plot.R`: Dieses R-Skript erzeugt die Plots zur visualisierung der Ergebnisse.
- `referenzdaten_fehlerplot.R`: Dieses R-Skript erstellt eine Fehlertabelle basierend auf Referenzdaten.
- `referenzdaten_fehleruntersuchung.ipynb`: Dies ist eine Jupyter-Notebook-Datei, die ein Skript zur Untersuchung von Fehlern in den Referenzdaten enthält.
- `schnittpunkt_plot.R`: Dieses R-Skript erzeugt einen Plot, welcher potenzielle Fehler veranschaulicht.

Weitere Details sind in dem Hauptdikument zu finden.

### Trafficcount-cv-gt-evaluation

Dieses Skript verarbeitet Verkehrsereignisdaten von OpenTrafficCam OTVision, die mit OTAnalytic und Groundtruth-Daten verarbeitet wurden, und gibt eine Reihe von binären Klassifikationstests für jedes Intervall aus.

#### Abhängigkeiten für Python

  * pandas
  * numpy
  * seaborn
  * matplotlib
  * re
  * datetime

#### Voraussetzungen für R
  * R (Version 3.6.0 oder höher)
  * R-Pakete: `tidyverse`, `lubridate`
