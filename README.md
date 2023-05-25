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
- `auswertung.ipynb`: Dies ist eine Jupyter-Notebook-Datei, die das Auswertungsskript enthält.
- `ganglinienplot.R`: Dieses R-Skript erzeugt Liniendiagramme.
- `merge.R`: Dieses R-Skript führt mehrere Datendateien zusammen.
- `plot.R`: Dieses R-Skript erzeugt verschiedene Plots.
- `referenzdaten_fehlerplot.R`: Dieses R-Skript erstellt Fehlerdiagramme basierend auf Referenzdaten.
- `referenzdaten_fehleruntersuchung.ipynb`: Dies ist eine Jupyter-Notebook-Datei, die ein Skript zur Untersuchung von Fehlern in den Referenzdaten enthält.
- `schnittpunkt_plot.R`: Dieses R-Skript erzeugt einen Plot, welcher potenzielle Fehler veranschaulicht.

## Skripte

### Trafficcount-cv-gt-evaluation

Dieses Skript verarbeitet Verkehrsereignisdaten von OpenTrafficCam OTVision, die mit OTAnalytic und Groundtruth-Daten verarbeitet wurden, und gibt eine Reihe von binären Klassifikationstests für jedes Intervall aus.

#### Abhängigkeiten für Python

  * pandas
  * numpy
  * seaborn
  * matplotlib
  * re
  * datetime


#### Verwendung

  1. Legen Sie die Pfade für die Groundtruth- und Evaluierungsdatensätze fest.
  2. Passen Sie die Intervalleinstellungen nach Bedarf an.
  3. Führen Sie das Skript aus, um die Daten zu verarbeiten und zu analysieren.

#### Funktionen

  * Liest und verarbeitet Daten aus verschiedenen Quellen und Formaten.
  * Filtert Daten nach Datumsbereich.
  * Vergleicht und verschmilzt Daten aus Groundtruth- und Evaluierungsdatensätzen.
  * Erzeugt binäre Klassifikationstests für festgelegte Intervalle.
  * Exportiert Ergebnisse in CSV-Dateien.

### Ground Truth Event Classification

Dieses R-Skript ver```markdown
arbeitet Groundtruth-Ereignisdaten, berechnet die Sensitivität und Genauigkeit für verschiedene Objektklassen und erzeugt Diagramme für jedes Tor und jede Objektklasse. Es ist darauf ausgelegt, mit Daten zu arbeiten, die während bestimmter Zeitintervalle gesammelt wurden.

#### Voraussetzungen für R
  * R (Version 3.6.0 oder höher)
  * R-Pakete: `tidyverse`, `lubridate`
