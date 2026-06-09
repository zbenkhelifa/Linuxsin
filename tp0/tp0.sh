#!/bin/bash
# ════════════════════════════════════════════════════
#  TP0 — Mise en route
#  LinuxSIN · STI2D SIN · Terminale
# ════════════════════════════════════════════════════
#  But : vérifier que tout fonctionne et découvrir
#        les premières commandes Linux.
#
#  Pour tester localement : bash tp0/tp0.sh
#  Pour valider            : pousse ton code sur GitHub
# ════════════════════════════════════════════════════

# ── Remplis ces deux lignes ───────────────────────
MON_PRENOM_NOM="Prénom NOM"   # ex: "Alice DUPONT"
MA_CLASSE="TS SIN 1"          # ex: "TS SIN 2"
# ─────────────────────────────────────────────────

# Q1. Affiche un message de bienvenue contenant ton nom
#     Utilise echo et la variable MON_PRENOM_NOM
q1_echo() {
    # ÉCRIS TA COMMANDE ICI

}

# Q2. Affiche la date et l'heure actuelles
q2_date() {
    # ÉCRIS TA COMMANDE ICI

}

# Q3. Affiche les informations sur le noyau Linux (version, architecture…)
#     Indice : uname avec l'option -a
q3_uname() {
    # ÉCRIS TA COMMANDE ICI

}

# Q4. Affiche le nom de la machine
q4_hostname() {
    # ÉCRIS TA COMMANDE ICI

}

# Q5. Affiche les 3 premières lignes de /etc/os-release
#     (informations sur la distribution Linux installée)
#     Indice : head
q5_os_release() {
    # ÉCRIS TA COMMANDE ICI

}

# ════════════════════════════════════════════════════
#  CORRECTION — Ne pas modifier à partir d'ici
# ════════════════════════════════════════════════════
SCORE=0; TOTAL=5

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
echo "  TP0 — Mise en route"
[[ "$MON_PRENOM_NOM" != "Prénom NOM" ]] && echo "  👤 $MON_PRENOM_NOM · $MA_CLASSE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

out=$(q1_echo 2>&1)
[[ "$out" =~ [A-Za-z] ]] && ok=1 || ok=0
chk "Q1 : echo → \"$out\"" "$ok" "Utilise : echo \"Bonjour \$MON_PRENOM_NOM\""

out=$(q2_date 2>&1)
[[ "$out" =~ [0-9] ]] && ok=1 || ok=0
chk "Q2 : date → affiche une date" "$ok" "Utilise la commande : date"

out=$(q3_uname 2>&1)
[[ "${out,,}" =~ linux ]] && ok=1 || ok=0
chk "Q3 : uname → informations noyau" "$ok" "Utilise : uname -a"

out=$(q4_hostname 2>&1)
[[ "$out" =~ [a-zA-Z0-9] ]] && ok=1 || ok=0
chk "Q4 : hostname → \"$out\"" "$ok" "Utilise la commande : hostname"

out=$(q5_os_release 2>&1)
[[ "$out" =~ = ]] && ok=1 || ok=0
chk "Q5 : /etc/os-release → distribution Linux" "$ok" "Utilise : head -3 /etc/os-release"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "  📊 Score TP0 : %d / %d\n" "$SCORE" "$TOTAL"
if   [ "$SCORE" -eq "$TOTAL" ]; then echo "  🎉 Parfait ! Passe au TP1."
elif [ "$SCORE" -ge 3 ];        then echo "  👍 Presque ! Relis les questions restantes."
else                                  echo "  💪 Continue ! Lis les commentaires dans tp0.sh"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
