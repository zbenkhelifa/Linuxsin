#!/bin/bash
# ════════════════════════════════════════════════════
#  TP5 — Mini-projet : profil GitHub en ligne de commande
#  LinuxSIN · STI2D SIN · Terminale
# ════════════════════════════════════════════════════
#
#  Objectif : écrire un script bash complet qui
#  interroge l'API GitHub, extrait des informations
#  et génère un rapport dans un fichier texte.
#
#  Usage : bash tp5/tp5.sh [pseudo_github]
#  Exemple : bash tp5/tp5.sh torvalds
#
#  Pour tester localement : bash tp5/tp5.sh torvalds
# ════════════════════════════════════════════════════

# ── Section A : Récupérer les données ────────────

# Utilise le pseudo passé en argument ($1), ou "torvalds" par défaut
# Indice : ${1:-"torvalds"}
PSEUDO=""  # REMPLACE "" PAR LA BONNE EXPRESSION

# Q1. Construis l'URL de l'API pour ce pseudo
#     Format : https://api.github.com/users/[pseudo]
URL_API=""  # REMPLACE "" PAR LA BONNE EXPRESSION

# Q2. Appelle l'API et stocke le résultat JSON dans une variable
#     Indice : REPONSE=$(curl -s "$URL_API")
REPONSE=""  # REMPLACE "" PAR LA BONNE EXPRESSION

# ── Section B : Extraire les champs ──────────────

# Q3. Extrait chaque champ depuis $REPONSE avec grep -oP
#     Indice pour le login : grep -oP '"login":\s*"\K[^"]+'
LOGIN=""
NOM=""          # champ "name"
REPOS=""        # champ "public_repos"
FOLLOWERS=""    # champ "followers"
LOCALISATION="" # champ "location"

# ── Section C : Générer le rapport ───────────────

# Q4. Affiche le rapport dans le terminal (avec echo)
#     Le rapport doit contenir : LOGIN, NOM, REPOS, FOLLOWERS, LOCALISATION

# ÉCRIS TON CODE ICI (affichage terminal)


# Q5. Sauvegarde le même rapport dans un fichier "rapport_[pseudo].txt"
#     Indice : echo "..." > "rapport_${PSEUDO}.txt"

# ÉCRIS TON CODE ICI (sauvegarde fichier)


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

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TP5 — Mini-projet : profil GitHub"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Q1 : PSEUDO défini et non vide
[ -n "$PSEUDO" ] && ok=1 || ok=0
chk "Q1 : pseudo → \"$PSEUDO\"" "$ok" "Écris : PSEUDO=\${1:-\"torvalds\"}"

# Q2 : URL contient le pseudo
[[ "$URL_API" =~ api.github.com ]] && ok=1 || ok=0
chk "Q2 : URL API → $URL_API" "$ok" "Écris : URL_API=\"https://api.github.com/users/\$PSEUDO\""

# Q3 : REPONSE contient du JSON
[[ "$REPONSE" =~ login ]] && ok=1 || ok=0
chk "Q3 : appel API → JSON reçu" "$ok" "Écris : REPONSE=\$(curl -s \"\$URL_API\")"

# Q4 : LOGIN extrait correctement
[ -n "$LOGIN" ] && ok=1 || ok=0
chk "Q4 : login extrait → \"$LOGIN\"" "$ok" "Écris : LOGIN=\$(echo \"\$REPONSE\" | grep -oP '\"login\":\\s*\"\\K[^\"]+')"

# Q5 : au moins 3 champs extraits (NOM ou REPOS ou FOLLOWERS)
extracted=0
[ -n "$NOM" ]          && ((extracted++))
[ -n "$REPOS" ]        && ((extracted++))
[ -n "$FOLLOWERS" ]    && ((extracted++))
[ -n "$LOCALISATION" ] && ((extracted++))
[ "$extracted" -ge 2 ] && ok=1 || ok=0
chk "Q5 : champs extraits ($extracted/4)" "$ok" "Extrait name, public_repos, followers avec grep -oP"

# Q6 : fichier rapport créé et non vide
rapport="rapport_${PSEUDO}.txt"
[ -f "$rapport" ] && [ -s "$rapport" ] && ok=1 || ok=0
chk "Q6 : rapport sauvegardé → $rapport" "$ok" "Écris le rapport dans : rapport_\${PSEUDO}.txt"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "  📊 Score TP5 : %d / %d\n" "$SCORE" "$TOTAL"
if   [ "$SCORE" -eq "$TOTAL" ]; then echo "  🎉 Mini-projet validé ! Formation terminée."
elif [ "$SCORE" -ge 4 ];        then echo "  👍 Presque ! Vérifie les sections B et C."
else                                  echo "  💪 Continue ! Lis bien chaque section A, B, C."
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
