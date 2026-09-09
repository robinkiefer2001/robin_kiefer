#!/bin/bash
# PRAXIS Tag 05 — Workshop: Vertrauenswürdige Pipelines.
# Nicht zu verwechseln mit dem gleichnamigen Projekt-Check im Repository
# techstyle. Geprüft wird das Wurzel-Verzeichnis: die Workflows liegen in
# .github/workflows/, der Code direkt im Repo-Wurzel — genau dort, wo GitHub
# Actions sie auch ausführt.
source .github/classroom/grade.sh

WF=.github/workflows

# PyYAML wird für die Struktur-Checks gebraucht (gültiges YAML, Job-Namen,
# needs-Verkettung). Auf ubuntu-latest ist es vorhanden; lokal ggf. nicht.
python3 -c "import yaml" 2>/dev/null \
  || python3 -m pip install --quiet --disable-pip-version-check pyyaml >/dev/null 2>&1

# Lädt eine Workflow-Datei und prüft sie mit einem Python-Ausdruck.
# Aufruf: wf_check <datei> <ausdruck über 'd' (dict) und 'jobs'>
wf_check() {
  python3 - "$1" "$2" <<'PY'
import sys

try:
    import yaml
except ImportError:
    sys.exit(1)

path, expr = sys.argv[1], sys.argv[2]
try:
    with open(path, encoding="utf-8") as fh:
        d = yaml.safe_load(fh)
except Exception:
    sys.exit(1)

if not isinstance(d, dict):
    sys.exit(1)
jobs = d.get("jobs")
jobs = jobs if isinstance(jobs, dict) else {}
sys.exit(0 if eval(expr) else 1)
PY
}

# Überschreibt die generischen Hinweise aus grade.sh mit Praxis-Hinweisen.
solution_for_id() {
  case "$1" in
    a1-yaml)
      echo "Bug 1 in $WF/a1-hello.yml: 'runs-on' gehört eine Ebene unter den Job 'hello'. Einrückung korrigieren, damit GitHub die Datei überhaupt als Workflow liest." ;;
    a1-action)
      echo "Bug 2 in $WF/a2-actions.yml: der Action-Name ist falsch geschrieben. Richtig ist 'actions/setup-python@v5'." ;;
    a1-deps)
      echo "Bug 3: der Workflow $WF/a3-deps.yml ruft pytest auf, requirements.txt kennt es aber nicht. Ergänze 'pytest' in requirements.txt." ;;
    a1-path)
      echo "Bug 4 in $WF/a4-tests.yml: 'working-directory: src' zeigt auf einen Ordner, den es nicht gibt. Die Tests liegen in tests/ im Wurzel-Verzeichnis." ;;
    a1-doku)
      echo "Lege DOKUMENTATION.md im Wurzel-Verzeichnis an (Dateiname komplett gross) und dokumentiere pro Workflow die Ursache und den Fix. Jeder der vier Namen a1-hello, a2-actions, a3-deps, a4-tests muss woertlich darin vorkommen — Format siehe README, Abschnitt 'Format der Abgabe-Dateien'." ;;
    a2-ci)
      echo "Lege $WF/ci.yml an — der Workflow, den du danach als Required Status Check auf main setzt." ;;
    a2-jobs)
      echo "ci.yml braucht die zwei Jobs 'lint' und 'test' (genau diese Namen, sie erscheinen so in der Branch-Protection-Regel)." ;;
    a2-pr-template)
      echo "Lege .github/pull_request_template.md mit einer kurzen Review-Checkliste an." ;;
    a2-codeowners)
      echo "Lege .github/CODEOWNERS an und trage euer Team bzw. eure GitHub-Handles ein. Gesucht wird mindestens eine Regelzeile aus Dateimuster, Leerzeichen und Handle — zum Beispiel '*  @dein-handle'; reine Kommentarzeilen zaehlen nicht." ;;
    a2-merge)
      echo "Der main-Branch enthält noch keinen Merge-Commit: den reparierten Branch über einen Pull Request mergen, nicht direkt pushen (Merge-Commit statt Squash/Rebase)." ;;
    a2-doku)
      echo "Halte in DOKUMENTATION.md das Ruleset fest (geschuetzter Branch, Required Status Checks lint + test) und nenne den Pull Request, dessen Check rot war. Gesucht werden zwei Dinge: das Wort Ruleset (oder Branch Protection / geschuetzt) und eine PR-Nummer der Form #12 bzw. ein Link .../pull/12." ;;
    a3-cache)
      echo "Aktiviere Dependency-Caching in ci.yml: 'cache: pip' bei actions/setup-python oder actions/cache." ;;
    a3-concurrency)
      echo "Ergänze in ci.yml einen concurrency-Block, damit überholte Läufe abgebrochen werden." ;;
    a3-parallel)
      echo "Entferne 'needs:' aus ci.yml, damit lint und test parallel statt nacheinander laufen." ;;
    a3-doku)
      echo "Dokumentiere in DOKUMENTATION.md die gemessene Laufzeit beider Laeufe und beschrifte sie woertlich mit vorher und nachher (z. B. als Tabelle mit den Zeilen vorher / nachher)." ;;
    *) echo "Überprüfe die Aufgabenstellung im README" ;;
  esac
}

echo "🔍 Prüfe Abnahmekriterien für Tag 05 Praxis — Vertrauenswürdige Pipelines"
echo ""
echo "── Auftrag 1: Broken Pipeline Challenge ──"

check "a1-yaml" \
  "Auftrag 1: Bug 1 behoben — a1-hello.yml ist gültiges YAML mit runs-on im Job" \
  "wf_check $WF/a1-hello.yml 'bool(jobs) and all(isinstance(j, dict) and j.get(\"runs-on\") for j in jobs.values())'"

check "a1-action" \
  "Auftrag 1: Bug 2 behoben — a2-actions.yml referenziert actions/setup-python korrekt" \
  "[ -f $WF/a2-actions.yml ] && grep -q 'actions/setup-python@' $WF/a2-actions.yml && ! grep -q 'setup-pyton' $WF/a2-actions.yml"

check "a1-deps" \
  "Auftrag 1: Bug 3 behoben — requirements.txt enthält pytest" \
  "grep -qiE '^[[:space:]]*pytest' requirements.txt 2>/dev/null"

check "a1-path" \
  "Auftrag 1: Bug 4 behoben — a4-tests.yml nutzt einen existierenden Testpfad" \
  "[ -f $WF/a4-tests.yml ] && grep -qi 'pytest' $WF/a4-tests.yml && ! grep -qE 'working-directory:.*src' $WF/a4-tests.yml"

check "a1-doku" \
  "Auftrag 1: DOKUMENTATION.md nennt die Ursache je Workflow (a1–a4)" \
  "[ -f DOKUMENTATION.md ] && grep -qi 'a1-hello' DOKUMENTATION.md && grep -qi 'a2-actions' DOKUMENTATION.md && grep -qi 'a3-deps' DOKUMENTATION.md && grep -qi 'a4-tests' DOKUMENTATION.md"

echo ""
echo "── Auftrag 2: PR-Gate und Branch Protection ──"

check "a2-ci" \
  "Auftrag 2: ci.yml vorhanden (der Workflow hinter dem Required Status Check)" \
  "[ -f $WF/ci.yml ]"

check "a2-jobs" \
  "Auftrag 2: ci.yml enthält die Jobs lint und test" \
  "wf_check $WF/ci.yml '\"lint\" in jobs and \"test\" in jobs'"

check "a2-pr-template" \
  "Auftrag 2: Pull-Request-Template vorhanden (.github/pull_request_template.md)" \
  "[ -f .github/pull_request_template.md ] || [ -f .github/PULL_REQUEST_TEMPLATE.md ]"

check "a2-codeowners" \
  "Auftrag 2: CODEOWNERS vorhanden und befüllt" \
  "{ [ -f .github/CODEOWNERS ] || [ -f CODEOWNERS ]; } && grep -qE '^[^#[:space:]]+[[:space:]]+@' .github/CODEOWNERS CODEOWNERS 2>/dev/null"

check "a2-merge" \
  "Auftrag 2: Merge-Commit in der History (über Pull Request gemergt statt direkt gepusht)" \
  "git log --merges --oneline | grep -q ."

check "a2-doku" \
  "Auftrag 2: DOKUMENTATION.md beschreibt das Ruleset und den roten Pull Request" \
  "[ -f DOKUMENTATION.md ] && grep -qiE 'ruleset|branch.?protection|geschützt' DOKUMENTATION.md && grep -qiE '(pull/[0-9]+|#[0-9]+)' DOKUMENTATION.md"

echo ""
echo "── Auftrag 3: Pipeline schneller machen ──"

check "a3-cache" \
  "Auftrag 3: Dependency-Caching in ci.yml aktiviert" \
  "[ -f $WF/ci.yml ] && grep -qE 'cache:[[:space:]]*(pip|poetry|pipenv)|actions/cache@' $WF/ci.yml"

check "a3-concurrency" \
  "Auftrag 3: concurrency-Block in ci.yml vorhanden" \
  "[ -f $WF/ci.yml ] && grep -qE '^[[:space:]]*concurrency:' $WF/ci.yml"

check "a3-parallel" \
  "Auftrag 3: lint und test laufen parallel (kein needs: mehr in ci.yml)" \
  "wf_check $WF/ci.yml 'len(jobs) >= 2 and not any(isinstance(j, dict) and j.get(\"needs\") for j in jobs.values())'"

check "a3-doku" \
  "Auftrag 3: DOKUMENTATION.md enthält die Laufzeit vorher und nachher" \
  "[ -f DOKUMENTATION.md ] && grep -qi 'vorher' DOKUMENTATION.md && grep -qi 'nachher' DOKUMENTATION.md"

summary 5
