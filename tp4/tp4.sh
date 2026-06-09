#!/bin/bash
# ════════════════════════════════════════════════════
#  TP4 — Réseau et protocoles
#  LinuxSIN · STI2D SIN · Terminale
# ════════════════════════════════════════════════════
#  Concepts du TP : HTTP  curl  wget  JSON  API REST
#
#  API utilisée : api.github.com (publique, sans clé)
#
#  Pour tester localement : bash tp4/tp4.sh
# ════════════════════════════════════════════════════

# ── Exercice 1 : Requêtes HTTP basiques ──────────

# Q1. Récupère le contenu de https://api.github.com/zen
#     (retourne une citation motivante en texte simple)
#     Indice : curl -s
q1_curl_get() {
    # ÉCRIS TA COMMANDE ICI

}

# Q2. Récupère uniquement le code de statut HTTP de https://api.github.com
#     Affiche seulement le nombre (ex : 200)
#     Indice : curl -s -o /dev/null -w "%{http_code}"
q2_code_http() {
    # ÉCRIS TA COMMANDE ICI

}

# Q3. Récupère les en-têtes HTTP (headers) de https://api.github.com
#     Indice : curl -sI
q3_headers() {
    # ÉCRIS TA COMMANDE ICI

}

# ── Exercice 2 : Travailler avec une API JSON ────

# Q4. Récupère les informations JSON du dépôt Linux de Linus Torvalds :
#     https://api.github.com/repos/torvalds/linux
#     Affiche le JSON brut (tu auras besoin de ce résultat pour Q5)
q4_curl_json() {
    # ÉCRIS TA COMMANDE ICI

}

# Q5. Récupère le même JSON que Q4 mais extrait seulement la valeur
#     du champ "stargazers_count" (nombre d'étoiles du dépôt)
#     Indice : curl -s ... | grep -oP '"stargazers_count":\s*\K[0-9]+'
#     Ou avec jq : curl -s ... | jq .stargazers_count
q5_extraire_json() {
    # ÉCRIS TA COMMANDE ICI

}

# ── Exercice 3 : Téléchargement ──────────────────

# Q6. Télécharge le fichier https://api.github.com/zen
#     et sauvegarde-le dans un fichier "citation.txt"
#     Indice : curl -s -o citation.txt URL  ou  wget -q -O citation.txt URL
q6_telecharger() {
    # ÉCRIS TA COMMANDE ICI

}

# ════════════════════════════════════════════════════
#  CORRECTION — Ne pas modifier à partir d'ici
# ════════════════════════════════════════════════════
SCORE=0; TOTAL=6

chk() {
    if [ "$2" = "1" ]; then
        echo "  ✅ $1"; ((SCORE++))
    else
        echo "  ❌ $1"
        [ -n "$3" ] && echo "     💡 $3"
    fi
}

TMPDIR_TP=$(mktemp -d)
cd "$TMPDIR_TP" || exit 1

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TP4 — Réseau et protocoles"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

out=$(q1_curl_get 2>&1)
[ -n "$out" ] && ok=1 || ok=0
chk "Q1 : curl zen → \"${out:0:60}\"" "$ok" "Utilise : curl -s https://api.github.com/zen"

out=$(q2_code_http 2>&1)
[[ "$out" =~ ^[0-9]{3}$ ]] && ok=1 || ok=0
chk "Q2 : code HTTP → $out" "$ok" "Utilise : curl -s -o /dev/null -w \"%{http_code}\" https://api.github.com"

out=$(q3_headers 2>&1)
[[ "${out,,}" =~ content-type|server|x-github ]] && ok=1 || ok=0
chk "Q3 : headers → en-têtes HTTP présents" "$ok" "Utilise : curl -sI https://api.github.com"

out=$(q4_curl_json 2>&1)
[[ "$out" =~ torvalds|linux|stargazers ]] && ok=1 || ok=0
chk "Q4 : JSON brut → réponse de l'API GitHub" "$ok" "Utilise : curl -s https://api.github.com/repos/torvalds/linux"

out=$(q5_extraire_json 2>&1)
[[ "$out" =~ ^[0-9]+$ ]] && ok=1 || ok=0
chk "Q5 : extraction JSON → $out étoiles" "$ok" "Utilise : ... | grep -oP '\"stargazers_count\":\\s*\\K[0-9]+'"

q6_telecharger 2>/dev/null
[ -f "citation.txt" ] && [ -s "citation.txt" ] && ok=1 || ok=0
chk "Q6 : téléchargement → citation.txt créé" "$ok" "Utilise : curl -s -o citation.txt https://api.github.com/zen"

rm -rf "$TMPDIR_TP"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "  📊 Score TP4 : %d / %d\n" "$SCORE" "$TOTAL"
if   [ "$SCORE" -eq "$TOTAL" ]; then echo "  🎉 Parfait ! Passe au TP5."
elif [ "$SCORE" -ge 4 ];        then echo "  👍 Bien ! Quelques exercices à finaliser."
else                                  echo "  💪 Continue ! Relis les commentaires dans tp4.sh"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
