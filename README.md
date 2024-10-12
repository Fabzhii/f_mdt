# f_mdt
FiveM MDT &amp; CAD System

## ⚠️ Achtung dieses Script kann noch Bugs verursachen und ist noch nicht zu 100% fertiggestellt!

![MDT](./images/dashboard.png)


## Installation
 - SQL einfügen
 - imgbb Token erstellen und einfügen
 - Outfit Template URL einfügen

## Exports
| Export             | Beschreibung |
| ----------------- | ------------------------------------------------------------------ | 
| exports[“f_mdt“]:setFlightMode(bool) | Setzt den Flugmodus damit der Spieler nicht mehr getrackt werden kann |
| exports[“f_mdt“]:getFlightMode() | Returnt den Flugmodus des Spielers |
| exports[“f_mdt“]:addDisatch(string(code, string, string, vector3) | Erstellt einen Dispatch |
| exports[“f_mdt“]:openMDT() | Öffnet das MDT (Jobs Checks werden nicht umgangen) |

## Inventory Item
```
["police_tablet"] = {
    label = "MDT",
    weight = 800,
    client = {
        export = "f_mdt.useTablet"
    }
},
```

## Funktionen
- Dashboard
  - Einsicht auf persönliche Informationen
  - Fahndungen
  - Globale Informationen
  - Beamte
  - Dispatches
- Leitstelle
  - Möglichkeit sich einzutragen
  - Verteilung der Einsatzkräfte
- Einwohnersuche
  - Einwohner Suchen
  - Bilder nehmen
  - Informationen über Personen
  - Personaldaten setzen
  - Fahnungen setzen
  - Lizenzen setzen
  - Notizen erstellen/löschen/bearbeiten
  - Akten erstellen/löschen/bearbeiten
- Fahrzeugsuche
  - Fahrzeuge suchen
  - Fahnung erstellen (Geplant)
- Waffensuche
  - Waffen suchen
  - Fahnung erstellen (Geplant)
- Tracking
  - Kennzeichen tracken
  - Telefonnummer tracken
- Dispatches
  - Dispatches einsehen
  - Dispatches bearbeiten/löschen
  - Beamte einteilen
- Listen
  - Mitarbeiter 
  - Fahrzeug 
  - Kleidung
  - Codes / Funks
  - Ausbildungen
  - Todo Liste
  - Gesetze
- Rechner
  - Strafen addieren
- Einstellungen
  - Berechtigungen von Rängen ändern
  - Nutzer * Rechte geben
- Panic
  - Panic Button auslösen ()
- Position
  - Position übertragen ()

