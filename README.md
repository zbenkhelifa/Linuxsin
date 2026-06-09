# LinuxSIN — Formation Linux pour STI2D SIN

> Formation Linux en 6 TP progressifs, 100% dans le navigateur.  
> Tu écris des commandes bash → GitHub les exécute sur un vrai Ubuntu → tu vois ta correction.

---

## Démarrer

1. **Fork ce dépôt** — clique sur "Fork" en haut à droite
2. **Ouvre un fichier TP** dans l'onglet "Code" de ton fork (ex : `tp0/tp0.sh`)
3. **Complète les fonctions** — remplace les `# ÉCRIS TA COMMANDE ICI` par tes commandes
4. **Commit & push** — en bas de la page GitHub, clique "Commit changes"
5. **Consulte ta correction** — onglet "Actions" → dernier workflow → lis les ✅ et ❌

Ton fichier `RESULTATS.md` à la racine du repo est mis à jour automatiquement après chaque push.

---

## Programme

| TP | Thème | Commandes clés |
|:---:|---|---|
| TP0 | Mise en route | `echo` `date` `uname` `hostname` |
| TP1 | Navigation et fichiers | `pwd` `ls` `mkdir` `touch` `cp` `mv` `rm` `wc` |
| TP2 | Permissions | `chmod` `stat` `id` `groups` |
| TP3 | Scripts bash | variables · conditions · boucles · fonctions |
| TP4 | Réseau et protocoles | `curl` `wget` · API REST · JSON |
| TP5 | Mini-projet | script complet · API GitHub · rapport |

Commence par **TP0**, puis avance dans l'ordre.

---

## Fonctionnement de la correction

Chaque fichier `tpX.sh` contient :
- Des **fonctions à compléter** en haut (les exercices)
- Une **section correction automatique** en bas (ne pas modifier)

Quand tu pushs, GitHub Actions lance ton script sur Ubuntu et affiche :
```
✅ Q1 : pwd → /home/runner/work
❌ Q2 : ls -la attendu
   💡 Utilise : ls -la
📊 Score TP1 : 7 / 10
```
