#!/bin/bash
# ════════════════════════════════════════════════════
#  TP3 — Scripts bash
#  LinuxSIN · STI2D SIN · Terminale
# ════════════════════════════════════════════════════
#  Concepts du TP : variables  conditions  boucles
#                   fonctions  arguments  arithmétique
#
#  Pour tester localement : bash tp3/tp3.sh
# ════════════════════════════════════════════════════

# ── Exercice 1 : Variables ────────────────────────

# Q1. Crée une variable "prenom" avec la valeur "Linux"
#     et affiche "Bonjour Linux !"
q1_variable() {
    # ÉCRIS TON CODE ICI

}

# Q2. Crée deux variables "a=10" et "b=3"
#     Affiche leur somme, leur produit et leur quotient entier
#     Indice : $(( ... ))
q2_arithmetique() {
    # ÉCRIS TON CODE ICI

}

# ── Exercice 2 : Conditions ───────────────────────

# Q3. Teste si le nombre 42 est supérieur à 10
#     Affiche "42 est grand" si vrai, "42 est petit" si faux
q3_condition() {
    # ÉCRIS TON CODE ICI

}

# Q4. Teste si le fichier /etc/passwd existe
#     Affiche "fichier trouvé" ou "fichier introuvable"
#     Indice : [ -f ... ]
q4_test_fichier() {
    # ÉCRIS TON CODE ICI

}

# ── Exercice 3 : Boucles ─────────────────────────

# Q5. Affiche les nombres de 1 à 5 avec une boucle for
q5_boucle_for() {
    # ÉCRIS TON CODE ICI

}

# Q6. Affiche un compte à rebours de 3 à 0 avec une boucle while
q6_boucle_while() {
    # ÉCRIS TON CODE ICI

}

# ── Exercice 4 : Fonctions et arguments ──────────

# Q7. Écris une fonction "saluer" qui reçoit un prénom ($1)
#     et affiche "Bonjour [prénom] !"
#     Appelle-la avec le prénom "Alice"
q7_fonction() {
    # ÉCRIS TON CODE ICI (définis et appelle la fonction)

}

# Q8. Affiche le premier argument reçu par le script ($1)
#     précédé de "Argument reçu : "
#     Cette fonction sera appelée avec l'argument "SIN"
q8_argument() {
    # ÉCRIS TON CODE ICI

}

# ── Exercice 5 : Substitution de commande ────────

# Q9. Stocke le résultat de "date" dans une variable
#     et affiche "Date du système : [résultat]"
#     Indice : variable=$(commande)
q9_substitution() {
    # ÉCRIS TON CODE ICI

}

# ════════════════════════════════════════════════════
#  CORRECTION — Ne pas modifier à partir d'ici
# ════════════════════════════════════════════════════
SCORE=0; TOTAL=9

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
echo "  TP3 — Scripts bash"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

out=$(q1_variable 2>&1)
[[ "$out" =~ Linux ]] && ok=1 || ok=0
chk "Q1 : variable → \"$out\"" "$ok" "Crée : prenom=\"Linux\" puis echo \"Bonjour \$prenom !\""

out=$(q2_arithmetique 2>&1)
[[ "$out" =~ 13 ]] && ok=1 || ok=0
chk "Q2 : arithmétique → somme=13 dans la sortie" "$ok" "Utilise : echo \$((a + b))"

out=$(q3_condition 2>&1)
[[ "${out,,}" =~ grand ]] && ok=1 || ok=0
chk "Q3 : condition → \"$out\"" "$ok" "Utilise : if [ 42 -gt 10 ]; then ..."

out=$(q4_test_fichier 2>&1)
[[ "${out,,}" =~ trouv ]] && ok=1 || ok=0
chk "Q4 : test fichier → \"$out\"" "$ok" "Utilise : if [ -f /etc/passwd ]; then echo \"fichier trouvé\" ..."

out=$(q5_boucle_for 2>&1)
lines=$(echo "$out" | wc -l)
[ "$lines" -ge 5 ] && ok=1 || ok=0
chk "Q5 : boucle for → $lines lignes affichées" "$ok" "Utilise : for i in 1 2 3 4 5; do echo \$i; done"

out=$(q6_boucle_while 2>&1)
[[ "$out" =~ 0 ]] && ok=1 || ok=0
chk "Q6 : boucle while → compte à rebours jusqu'à 0" "$ok" "Utilise : while [ \$n -ge 0 ]; do ..."

out=$(q7_fonction 2>&1)
[[ "${out,,}" =~ alice ]] && ok=1 || ok=0
chk "Q7 : fonction → \"$out\"" "$ok" "Définis saluer() { echo \"Bonjour \$1 !\"; } puis appelle saluer \"Alice\""

out=$(q8_argument "SIN" 2>&1)
[[ "$out" =~ SIN ]] && ok=1 || ok=0
chk "Q8 : argument → \"$out\"" "$ok" "Utilise : echo \"Argument reçu : \$1\""

out=$(q9_substitution 2>&1)
[[ "$out" =~ [0-9] ]] && ok=1 || ok=0
chk "Q9 : substitution → \"$out\"" "$ok" "Utilise : maintenant=\$(date) puis echo \"Date : \$maintenant\""

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "  📊 Score TP3 : %d / %d\n" "$SCORE" "$TOTAL"
if   [ "$SCORE" -eq "$TOTAL" ]; then echo "  🎉 Parfait ! Passe au TP4."
elif [ "$SCORE" -ge 6 ];        then echo "  👍 Bien ! Quelques exercices à finaliser."
else                                  echo "  💪 Continue ! Relis les commentaires dans tp3.sh"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
