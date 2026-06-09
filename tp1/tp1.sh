#!/bin/bash
# ════════════════════════════════════════════════════
#  TP1 — Navigation et fichiers Linux
#  LinuxSIN · STI2D SIN · Terminale
# ════════════════════════════════════════════════════
#  Commandes du TP : pwd  ls  mkdir  touch  cp  mv  rm  wc
#
#  Pour tester localement : bash tp1/tp1.sh
# ════════════════════════════════════════════════════

# ── Exercice 1 : S'orienter ──────────────────────

# Q1. Affiche le répertoire courant (chemin absolu)
q1_pwd() {
    # ÉCRIS TA COMMANDE ICI

}

# Q2. Liste les fichiers et dossiers du répertoire courant
q2_ls() {
    # ÉCRIS TA COMMANDE ICI

}

# Q3. Liste avec tous les détails : permissions, taille, date
#     (fichiers cachés inclus)
q3_ls_detail() {
    # ÉCRIS TA COMMANDE ICI

}

# Q4. Affiche le nom de l'utilisateur connecté
q4_whoami() {
    # ÉCRIS TA COMMANDE ICI

}

# ── Exercice 2 : Créer et organiser ──────────────

# Q5. Crée un répertoire nommé "projets"
q5_mkdir() {
    # ÉCRIS TA COMMANDE ICI

}

# Q6. Crée un fichier vide nommé "notes.txt"
q6_touch() {
    # ÉCRIS TA COMMANDE ICI

}

# Q7. Copie "notes.txt" vers "backup.txt"
q7_cp() {
    # ÉCRIS TA COMMANDE ICI

}

# Q8. Renomme "backup.txt" en "archive.txt"
q8_mv() {
    # ÉCRIS TA COMMANDE ICI

}

# ── Exercice 3 : Analyser ────────────────────────

# Q9. Supprime le fichier "archive.txt"
q9_rm() {
    # ÉCRIS TA COMMANDE ICI

}

# Q10. Affiche le nombre de lignes du fichier /etc/passwd
#      Indice : wc avec l'option -l
q10_wc() {
    # ÉCRIS TA COMMANDE ICI

}

# ════════════════════════════════════════════════════
#  CORRECTION — Ne pas modifier à partir d'ici
# ════════════════════════════════════════════════════
SCORE=0; TOTAL=10

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
echo "  TP1 — Navigation et fichiers"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

out=$(q1_pwd 2>&1)
[[ "$out" =~ ^/ ]] && ok=1 || ok=0
chk "Q1 : pwd → $out" "$ok" "Utilise la commande : pwd"

out=$(q2_ls 2>&1)
[ -n "$out" ] && ok=1 || ok=0
chk "Q2 : ls → liste les fichiers" "$ok" "Utilise la commande : ls"

out=$(q3_ls_detail 2>&1)
[[ "$out" =~ total|^d|^- ]] && ok=1 || ok=0
chk "Q3 : ls -la → affiche les détails" "$ok" "Utilise : ls -la"

out=$(q4_whoami 2>&1)
[ -n "$out" ] && ok=1 || ok=0
chk "Q4 : whoami → $out" "$ok" "Utilise la commande : whoami"

q5_mkdir 2>/dev/null
[ -d "projets" ] && ok=1 || ok=0
chk "Q5 : mkdir → dossier 'projets' créé" "$ok" "Utilise : mkdir projets"

q6_touch 2>/dev/null
[ -f "notes.txt" ] && ok=1 || ok=0
chk "Q6 : touch → fichier 'notes.txt' créé" "$ok" "Utilise : touch notes.txt"

touch notes.txt 2>/dev/null   # garantit que notes.txt existe pour q7
q7_cp 2>/dev/null
[ -f "backup.txt" ] && ok=1 || ok=0
chk "Q7 : cp → 'backup.txt' créé" "$ok" "Utilise : cp notes.txt backup.txt"

touch backup.txt 2>/dev/null  # garantit que backup.txt existe pour q8
q8_mv 2>/dev/null
{ [ -f "archive.txt" ] && [ ! -f "backup.txt" ]; } && ok=1 || ok=0
chk "Q8 : mv → 'backup.txt' renommé en 'archive.txt'" "$ok" "Utilise : mv backup.txt archive.txt"

touch archive.txt 2>/dev/null # garantit qu'archive.txt existe pour q9
q9_rm 2>/dev/null
[ ! -f "archive.txt" ] && ok=1 || ok=0
chk "Q9 : rm → 'archive.txt' supprimé" "$ok" "Utilise : rm archive.txt"

out=$(q10_wc 2>&1)
[[ "$out" =~ ^[0-9] ]] && ok=1 || ok=0
chk "Q10 : wc -l → $out lignes dans /etc/passwd" "$ok" "Utilise : wc -l /etc/passwd"

rm -rf "$TMPDIR_TP"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "  📊 Score TP1 : %d / %d\n" "$SCORE" "$TOTAL"
if   [ "$SCORE" -eq "$TOTAL" ]; then echo "  🎉 Parfait ! Passe au TP2."
elif [ "$SCORE" -ge 7 ];        then echo "  👍 Bien ! Quelques commandes à revoir."
else                                  echo "  💪 Continue ! Relis les commentaires dans tp1.sh"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
