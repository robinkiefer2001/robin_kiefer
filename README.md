# Tag 05 Praxis — Vertrauenswürdige Pipelines

> **Praxisaufträge.** Dieses Repository ist dein Arbeitsplatz für die
> Praxis-Übungen von Tag 05. Anders als an Tag 04 ist es **nicht leer**:
> es enthält vier Workflows, die alle kaputt sind. Das ist Absicht.

## Ausgangslage

An Tag 04 hast du eine CI-Pipeline gebaut. Heute geht es um die zwei Dinge,
die danach kommen: eine **kaputte Pipeline reparieren** und eine laufende
Pipeline so einsetzen, dass sie den `main`-Branch tatsächlich **schützt**
und dabei **schnell** bleibt.

Die drei Aufträge bauen aufeinander auf:

1. **Auftrag 1** — vier rote Workflows reparieren (Fehlerklassen kennenlernen).
2. **Auftrag 2** — aus der reparierten Pipeline ein PR-Gate machen.
3. **Auftrag 3** — dasselbe Gate messbar schneller machen.

## Ordnerstruktur

Alle Dateien gehören ins **Wurzel-Verzeichnis** dieses Repos bzw. in
`.github/`. Lege keine Unterordner pro Auftrag an; die automatische Prüfung
sucht die Dateien genau hier.

```
.github/workflows/a1-hello.yml        # Auftrag 1, Bug 1 — kaputt
.github/workflows/a2-actions.yml      # Auftrag 1, Bug 2 — kaputt
.github/workflows/a3-deps.yml         # Auftrag 1, Bug 3 — kaputt
.github/workflows/a4-tests.yml        # Auftrag 1, Bug 4 — kaputt
.github/workflows/ci.yml              # Auftrag 2, in Auftrag 3 optimiert
.github/pull_request_template.md      # Auftrag 2
.github/CODEOWNERS                    # Auftrag 2
DOKUMENTATION.md                      # Auftrag 1-3, dein schriftlicher Teil (Vorlage liegt bereit)
app.py, tests/, conftest.py           # gegeben — nicht verändern nötig
requirements.txt                      # Auftrag 1, Bug 3
```

---

## Format der Abgabe-Dateien

Der Autograder liest deine Dateien mit einer einfachen Textsuche. Er beurteilt
**nicht**, ob deine Erklärung fachlich stimmt — das macht die Lehrperson beim
Durchsehen. Er prüft nur: liegt die Datei am richtigen Ort, und kommen die
geforderten Angaben überhaupt darin vor?

Deshalb gilt: **Inhalt frei, Struktur verbindlich.** Wer sich an das Format
hält, bekommt die Punkte für seine eigene Analyse. Wer die Datei anders nennt
oder die Kernangabe weglässt, verliert sie trotz richtiger Arbeit.

### `DOKUMENTATION.md`

| Regel | Warum |
| --- | --- |
| Dateiname **exakt `DOKUMENTATION.md`**, alle Buchstaben gross | Der Prüf-Runner läuft unter Linux — `Dokumentation.md` oder `dokumentation.md` sind dort **andere** Dateien und werden nicht gefunden. |
| Liegt im **Wurzel-Verzeichnis** des Repos, nicht in `docs/` oder `auftrag1/` | Die Prüfung sucht genau einen Pfad. |
| Kodierung **UTF-8** | Sonst werden Umlaute in Suchbegriffen wie `geschützt` nicht erkannt. |
| Genau **drei Abschnitte**, einer pro Auftrag | Du füllst dieselbe Datei über den ganzen Tag weiter — nicht drei einzelne Dateien anlegen. |

Eine leere Vorlage mit allen Überschriften liegt bereits im Repo. Ersetze darin
jeden `<Platzhalter>`.

**Abschnitt Auftrag 1 — Pflichtangabe:** eine Zeile je repariertem Workflow, und
in dieser Zeile muss der **Workflow-Name ohne `.yml`** wörtlich stehen. Alle vier
Namen müssen vorkommen: `a1-hello`, `a2-actions`, `a3-deps`, `a4-tests`. Was du
daneben schreibst — Symptom, Ursache, Fix — ist deine Analyse und wird von der
Lehrperson bewertet.

**Abschnitt Auftrag 2 — zwei Pflichtangaben:**

1. Nenne das Regelwerk **beim Namen**: eines der Wörter `Ruleset`,
   `Branch Protection` oder `geschützt` muss im Text vorkommen. Danach
   beschreibst du in eigenen Worten, welche Regeln du auf `main` setzen würdest.
2. Verweise auf den Pull Request, dessen Check rot war — als **Nummer mit
   Rautezeichen** (`#12`) oder als vollständigen Link (`.../pull/12`).
   Formulierungen wie „mein PR von heute Morgen“ genügen nicht, weil keine
   Nummer darin steht.

**Abschnitt Auftrag 3 — Pflichtangabe:** beide Messungen müssen mit den Wörtern
**`vorher`** und **`nachher`** beschriftet sein. Ob als Tabelle oder als Fliesstext
ist egal, solange beide Wörter samt zugehöriger Laufzeit dastehen. Die
Zeitangabe selbst ist frei (`2m 40s`, `160 s`, `02:40`).

**Vorlage — so ist das Format gemeint:**

```markdown
# Dokumentation — Tag 05 Praxis

**Gruppe:** Anna Muster, Ben Beispiel

## Auftrag 1 — Broken Pipeline

| Workflow    | Symptom (wo bricht der Lauf ab?) | Ursache | Fix |
| ----------- | -------------------------------- | ------- | --- |
| a1-hello    | ...                              | ...     | ... |
| a2-actions  | ...                              | ...     | ... |
| a3-deps     | ...                              | ...     | ... |
| a4-tests    | ...                              | ...     | ... |

## Auftrag 2 — PR-Gate

### Ruleset auf `main`
Diese Regeln würden wir setzen: ...

### Pull Request mit rotem Check
Pull Request #12 — der Check ... war rot, weil ...; repariert mit ...

## Auftrag 3 — Laufzeit

| Messung | Dauer von ci.yml |
| ------- | ---------------- |
| vorher  | 2m 40s           |
| nachher | 1m 05s           |

**Trade-off der Parallelisierung:** ...
```

Die Zellen mit `...` füllst du selbst — genau das ist der bewertete Teil.

### `.github/pull_request_template.md`

Geprüft wird nur, dass die Datei existiert (`.github/pull_request_template.md`
oder `.github/PULL_REQUEST_TEMPLATE.md`). Inhaltlich erwartet wird eine kurze
Review-Checkliste in Markdown-Checkboxen, zum Beispiel:

```markdown
## Was ändert dieser PR?

## Checkliste
- [ ] Tests laufen lokal grün
- [ ] ...
```

### `.github/CODEOWNERS`

Diese Datei ist **kein Markdown** und hat eine eigene Syntax: pro Zeile ein
Dateimuster, dann mindestens ein Leerzeichen, dann ein GitHub-Handle mit `@`.
Genau darauf prüft der Autograder — eine Datei, die nur Kommentarzeilen (`#`)
enthält, zählt als leer.

```
# Muster        Zuständige
*               @dein-handle @handle-partnerin
```

### Was der Autograder wörtlich sucht

| Kriterium | Datei | Muss wörtlich vorkommen |
| --- | --- | --- |
| Auftrag 1: Ursache je Workflow | `DOKUMENTATION.md` | `a1-hello`, `a2-actions`, `a3-deps`, `a4-tests` |
| Auftrag 2: Ruleset und roter PR | `DOKUMENTATION.md` | `Ruleset` **oder** `Branch Protection` **oder** `geschützt` — **und** eine PR-Nummer (`#12` bzw. `.../pull/12`) |
| Auftrag 3: Laufzeit | `DOKUMENTATION.md` | `vorher` **und** `nachher` |
| Auftrag 2: CODEOWNERS befüllt | `.github/CODEOWNERS` | eine Zeile `<muster> @<handle>` |

Gross- und Kleinschreibung ist **innerhalb** der Dateien egal (`Vorher` zählt
wie `vorher`); nur beim **Dateinamen** `DOKUMENTATION.md` zählt sie.

> **Selbst prüfen statt raten:** `bash .github/classroom/grade.sh` sagt dir
> lokal in Sekunden, welche Angabe noch fehlt — ohne Push und ohne Wartezeit.

---

## Auftrag 1 — Broken Pipeline Challenge

**Zeit:** 35 Min | **Format:** Zweiergruppe (Pair Programming)

Die vier Workflows `a1-hello`, `a2-actions`, `a3-deps` und `a4-tests` sind
kaputt — jeder auf eine andere Art. Repariere sie **einzeln**, bis alle vier
im Tab **Actions** grün sind.

**Regel:** erst das Log lesen, dann raten. Jeder Fehler bricht in einer anderen
Phase ab, und wo der Lauf stoppt, verrät die Fehlerklasse:

| Wo es abbricht | Fehlerklasse |
| --- | --- |
| Der Workflow erscheint gar nicht in *Actions* | Die Datei ist kein gültiges YAML — GitHub kann sie nicht laden. |
| Abbruch vor dem ersten Schritt | Eine `uses:`-Referenz lässt sich nicht auflösen. |
| Abbruch im Schritt, der Tools aufruft | Eine Abhängigkeit fehlt in `requirements.txt`. |
| Abbruch im Schritt selbst, mit Pfadmeldung | Ein Pfad oder `working-directory` zeigt ins Leere. |

**Vorgehen pro Bug**

1. Lauf in **Actions** öffnen, Log des roten Schritts aufklappen, Meldung lesen.
2. Ursache benennen, **bevor** du etwas änderst.
3. Fix committen und pushen, grünen Lauf abwarten.
4. In `DOKUMENTATION.md` festhalten: Workflow-Name, Symptom, Ursache, Fix.
   Der Workflow-Name muss dabei woertlich dastehen (`a1-hello` usw.) — siehe
   [Format der Abgabe-Dateien](#format-der-abgabe-dateien).

**Deliverable:** vier grüne Läufe + der Abschnitt *Auftrag 1* in
`DOKUMENTATION.md` mit einer Zeile je Workflow — alle vier Workflow-Namen
(`a1-hello`, `a2-actions`, `a3-deps`, `a4-tests`) müssen darin vorkommen.

**Quellen zum Einarbeiten**

- [GitHub Docs – Workflow syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions) *(EN, Referenz zu jobs, runs-on, steps und der Einrückung)*
- [GitHub Docs – Using pre-written building blocks](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-pre-written-building-blocks) *(EN, wie `uses:` eine Action auflöst)*
- [GitHub Docs – Monitoring and troubleshooting workflows](https://docs.github.com/en/actions/how-tos/monitor-workflows) *(EN, Logs lesen und Läufe erneut starten)*
- [actions/setup-python](https://github.com/actions/setup-python) *(EN, korrekter Action-Name, Versionen, Caching)*

---

## Auftrag 2 — PR-Gate und Branch Protection

**Zeit:** 30 Min | **Format:** Zweiergruppe

Vier grüne Workflows sind schön — sie hindern aber niemanden daran, roten
Code direkt nach `main` zu pushen. In diesem Auftrag machst du aus der Pipeline
ein **Gate**.

1. **`ci.yml` anlegen** mit genau zwei Jobs: **`lint`** (flake8) und **`test`**
   (pytest), zunächst verkettet mit `needs: lint` — wie die TechStyle-Pipeline
   aus Tag 04. Trigger: `push` auf `main` und `pull_request` auf `main`.
   > Die Job-Namen `lint` und `test` sind vorgegeben: genau unter diesen Namen
   > taucht ein Job später in der Ruleset-Auswahl als *Required Status Check* auf.
2. **`.github/pull_request_template.md`** mit einer kurzen Review-Checkliste
   anlegen — es füllt jede PR-Beschreibung automatisch vor.
3. **`.github/CODEOWNERS`** anlegen und eure GitHub-Handles eintragen, damit
   Reviews automatisch angefragt werden. Mindestens eine echte Regelzeile
   (`*` + Leerzeichen + `@handle`), nicht nur Kommentare.
4. **Den Ablauf durchspielen:** Branch anlegen → eine Änderung committen, die
   `test` rot macht (z. B. einen falschen Erwartungswert in `tests/test_app.py`)
   → Pull Request öffnen → den roten Check am PR anschauen → im selben PR
   reparieren → grün abwarten → **mit Merge-Commit** mergen (nicht Squash,
   nicht Rebase).
5. **Das Ruleset dokumentieren.** Beschreibe in `DOKUMENTATION.md`, welche
   Regeln du auf `main` setzen würdest: *Require a pull request before merging*,
   *Require status checks to pass* mit `lint` und `test`, *Block force pushes*.

> **Warum nur dokumentiert?** Rulesets und Branch Protection sind auf privaten
> Repositories nur in bezahlten GitHub-Plänen verfügbar; dieses Repo ist
> privat und die Organisation läuft auf dem Free-Plan. Die Lehrperson zeigt die
> Konfiguration live an einem öffentlichen Repo. Fachlich ändert das nichts:
> das Gate besteht aus der Pipeline, dem PR-Ablauf und der Review-Regel — das
> Ruleset macht daraus nur eine erzwungene statt einer vereinbarten Regel.

**Deliverable:** `ci.yml`, PR-Template, `CODEOWNERS`, ein über einen Pull
Request gemergter Branch und der Abschnitt *Auftrag 2* in `DOKUMENTATION.md`
mit Ruleset-Beschreibung und PR-Nummer im Format `#12` — siehe
[Format der Abgabe-Dateien](#format-der-abgabe-dateien).

**Quellen zum Einarbeiten**

- [GitHub Docs – About rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets) *(EN, was ein Ruleset regeln kann)*
- [GitHub Docs – Available rules for rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets) *(EN, Required status checks, Required pull request, Block force pushes)*
- [GitHub Docs – About code owners](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) *(EN, Syntax der CODEOWNERS-Datei)*
- [GitHub Docs – Creating a pull request template](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository) *(EN, Ablageort und Aufbau)*
- [GitHub Docs – About merge methods](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges) *(EN, Merge-Commit vs. Squash vs. Rebase)*

---

## Auftrag 3 — Pipeline schneller machen

**Zeit:** 25 Min | **Format:** Zweiergruppe

Ein Gate, das drei Minuten braucht, wird umgangen. Mache `ci.yml` messbar
schneller — mit drei Hebeln:

1. **Caching:** `cache: pip` bei `actions/setup-python` (oder `actions/cache`).
2. **Parallelisierung:** `needs:` entfernen, damit `lint` und `test` gleichzeitig
   laufen statt nacheinander.
3. **`concurrency`:** überholte Läufe auf demselben Branch abbrechen.

```yaml
concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true
```

**Miss beides.** Notiere die Gesamtlaufzeit von `ci.yml` **vor** und **nach**
den Änderungen — in `DOKUMENTATION.md` beschriftet als `vorher` und `nachher` — (Actions → Lauf → Dauer oben rechts). Der Cache greift erst ab
dem zweiten Lauf — miss also nicht den allerersten.

**Deliverable:** optimiertes `ci.yml` und der Abschnitt *Auftrag 3* in
`DOKUMENTATION.md` mit beiden Messungen — beschriftet mit den Wörtern
`vorher` und `nachher` — und einem Satz zum Trade-off der Parallelisierung.

**Quellen zum Einarbeiten**

- [GitHub Docs – Caching dependencies to speed up workflows](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/cache-dependencies) *(EN, wie der Cache-Key funktioniert)*
- [actions/setup-python – Caching packages](https://github.com/actions/setup-python#caching-packages-dependencies) *(EN, `cache: pip` in einer Zeile)*
- [GitHub Docs – Control the concurrency of workflows and jobs](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/control-the-concurrency-of-workflows-and-jobs) *(EN, group und cancel-in-progress)*
- [GitHub Docs – Using jobs in a workflow](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-jobs) *(EN, was `needs:` bewirkt und wann es weg darf)*

---

## Abnahmekriterien

Diese Kriterien prüft die Pipeline bei jedem Push automatisch. **Die Haken
setzt die Pipeline selbst:** ein erfülltes Kriterium wird abgehakt, und
sobald eine Änderung es wieder bricht, verschwindet der Haken. Du musst hier
nichts von Hand pflegen — beim nächsten Push wird die Liste überschrieben.

<!-- c50:progress -->
**Fortschritt: 2 / 15 Kriterien erfüllt** 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ — Stand: 2026-09-09 08:20 UTC.
<!-- /c50:progress -->

- [x] ✅ Auftrag 1: Bug 1 behoben — a1-hello.yml ist gültiges YAML mit runs-on im Job
- [x] ✅ Auftrag 1: Bug 2 behoben — a2-actions.yml referenziert actions/setup-python korrekt
- [ ] ⬜ Auftrag 1: Bug 3 behoben — requirements.txt enthält pytest
- [ ] ⬜ Auftrag 1: Bug 4 behoben — a4-tests.yml nutzt einen existierenden Testpfad
- [ ] ⬜ Auftrag 1: DOKUMENTATION.md nennt die Ursache je Workflow (a1–a4)
- [ ] ⬜ Auftrag 2: ci.yml vorhanden (der Workflow hinter dem Required Status Check)
- [ ] ⬜ Auftrag 2: ci.yml enthält die Jobs lint und test
- [ ] ⬜ Auftrag 2: Pull-Request-Template vorhanden (.github/pull_request_template.md)
- [ ] ⬜ Auftrag 2: CODEOWNERS vorhanden und befüllt
- [ ] ⬜ Auftrag 2: Merge-Commit in der History (über Pull Request gemergt statt direkt gepusht)
- [ ] ⬜ Auftrag 2: DOKUMENTATION.md beschreibt das Ruleset und den roten Pull Request
- [ ] ⬜ Auftrag 3: Dependency-Caching in ci.yml aktiviert
- [ ] ⬜ Auftrag 3: concurrency-Block in ci.yml vorhanden
- [ ] ⬜ Auftrag 3: lint und test laufen parallel (kein needs: mehr in ci.yml)
- [ ] ⬜ Auftrag 3: DOKUMENTATION.md enthält die Laufzeit vorher und nachher

Zusätzlich manuell abgenommen (nicht automatisch geprüft):

- Alle vier Workflows aus Auftrag 1 laufen im Tab *Actions* grün
- Der rote Check am Pull Request wurde beobachtet, bevor er repariert wurde

## Abnahmekriterien selber prüfen

**Lokal** — jederzeit, ohne Push:

```bash
bash .github/classroom/grade.sh
```

Das Skript liest die Tagesnummer aus `.classroom50.yaml`. Du kannst sie
auch erzwingen:

```bash
CLASSROOM_DAY=5 bash .github/classroom/grade.sh
```

Die Ausgabe listet jedes Kriterium mit ✅ oder ❌ und nennt bei jedem ❌
den konkreten Lösungshinweis. Sobald ein Kriterium fehlt, endet das
Skript mit Exit-Code 1.

**In GitHub** — bei jedem Push:

Der Workflow **🎓 Classroom Autograding** läuft automatisch und hakt die
erfüllten Kriterien oben im README ab. Ergebnis im Tab **Actions** →
letzter Run → Job *Abnahmekriterien prüfen*.

Die Punktzahl ist **anteilig**: jedes erfüllte Abnahmekriterium zählt einen
Punkt (z. B. `Points 9/15`). Grün wird der Lauf erst, wenn alle Kriterien
erfüllt sind — Teilpunkte gibt es aber ab dem ersten.

## Musterlösung

Nach dem Unterricht findest du die Musterlösung im Repository
[`tbzdevops/musterloesungen-praxisauftraege`](https://github.com/tbzdevops/musterloesungen-praxisauftraege/tree/day_5_solution)
auf dem Branch `day_5_solution`.
