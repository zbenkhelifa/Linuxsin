#!/bin/bash
# ════════════════════════════════════════════════════
#  TP2 — Permissions et utilisateurs
#  LinuxSIN · STI2D SIN · Terminale
# ════════════════════════════════════════════════════
#  Commandes du TP : chmod  stat  ls -l  id  groups
#
#  Rappel des permissions Linux :
#    r = lecture (4)   w = écriture (2)   x = exécution (1)
#    Ex : chmod 644 → rw-r--r--
#         chmod 755 → rwxr-xr-x
#
#  Pour tester localement : bash tp2/tp2.sh
# ════════════════════════════════════════════════════

# ── Exercice 1 : Lire les permissions ────────────

# Q1. Affiche la liste détaillée du répertoire /etc
#     (pour observer les permissions des fichiers système)
q1_ls_permissions() {
    # ÉCRIS TA COMMANDE ICI

}

# Q2. Affiche les informations détaillées (taille, permissions, dates)
#     du fichier /etc/hostname
#     Indice : stat
q2_stat() {
    # ÉCRIS TA COMMANDE ICI

}

# ── Exercice 2 : Modifier les permissions ────────

# Q3. Donne les permissions 644 (rw-r--r--) au fichier "fichier.txt"
#     (le propriétaire peut lire et écrire, les autres lisent seulement)
q3_chmod_644() {
    # ÉCRIS TA COMMANDE ICI

}

# Q4. Donne les permissions 755 (rwxr-xr-x) au fichier "script.sh"
#     (le propriétaire peut tout faire, les autres peuvent lire et exécuter)
q4_chmod_755() {
    # ÉCRIS TA COMMANDE ICI

}

# Q5. Rends le fichier "mon_script.sh" exécutable
#     Indice : chmod +x
q5_chmod_x() {
    # ÉCRIS TA COMMANDE ICI

}

# ── Exercice 3 : Utilisateurs et groupes ─────────

# Q6. Affiche les informations de l'utilisateur courant
#     (uid, gid, groupes)
#     Indice : id
q6_id() {
    # ÉCRIS TA COMMANDE ICI

}

# Q7. Affiche les groupes auxquels appartient l'utilisateur courant
q7_groups() {
    # ÉCRIS TA COMMANDE ICI

}

# Q8. Essaie de lire le fichier /etc/shadow
#     Observe le message d'erreur : certains fichiers sont réservés à root
q8_shadow() {
    # ÉCRIS TA COMMANDE ICI (indice : cat)

}

# ════════════════════════════════════════════════════
#  CORRECTION — Ne pas modifier à partir d'ici
# ════════════════════════════════════════════════════
SCORE=0; TOTAL=8

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
touch fichier.txt script.sh mon_script.sh

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  TP2 — Permissions et utilisateurs"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

out=$(q1_ls_permissions 2>&1)
[[ "$out" =~ ^d|^-|^l|^total ]] && ok=1 || ok=0
chk "Q1 : ls /etc → liste avec permissions" "$ok" "Utilise : ls -l /etc"

out=$(q2_stat 2>&1)
[[ "${out,,}" =~ size|taille|file|fichier ]] && ok=1 || ok=0
chk "Q2 : stat /etc/hostname → informations fichier" "$ok" "Utilise : stat /etc/hostname"

q3_chmod_644 2>/dev/null
perms=$(stat -c "%a" fichier.txt 2>/dev/null)
[ "$perms" = "644" ] && ok=1 || ok=0
chk "Q3 : chmod 644 fichier.txt → permissions $perms" "$ok" "Utilise : chmod 644 fichier.txt"

q4_chmod_755 2>/dev/null
perms=$(stat -c "%a" script.sh 2>/dev/null)
[ "$perms" = "755" ] && ok=1 || ok=0
chk "Q4 : chmod 755 script.sh → permissions $perms" "$ok" "Utilise : chmod 755 script.sh"

q5_chmod_x 2>/dev/null
[ -x "mon_script.sh" ] && ok=1 || ok=0
chk "Q5 : chmod +x mon_script.sh → exécutable" "$ok" "Utilise : chmod +x mon_script.sh"

out=$(q6_id 2>&1)
[[ "$out" =~ uid= ]] && ok=1 || ok=0
chk "Q6 : id → uid, gid, groupes" "$ok" "Utilise la commande : id"

out=$(q7_groups 2>&1)
[ -n "$out" ] && ok=1 || ok=0
chk "Q7 : groups → $out" "$ok" "Utilise la commande : groups"

out=$(q8_shadow 2>&1)
[[ "${out,,}" =~ permission|denied|shadow ]] && ok=1 || ok=0
chk "Q8 : /etc/shadow → accès refusé (normal !)" "$ok" "Utilise : cat /etc/shadow"

rm -rf "$TMPDIR_TP"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "  📊 Score TP2 : %d / %d\n" "$SCORE" "$TOTAL"
if   [ "$SCORE" -eq "$TOTAL" ]; then echo "  🎉 Parfait ! Passe au TP3."
elif [ "$SCORE" -ge 5 ];        then echo "  👍 Bien ! Quelques exercices à finaliser."
else                                  echo "  💪 Continue ! Relis les commentaires dans tp2.sh"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
