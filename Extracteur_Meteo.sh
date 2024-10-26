# Vérification que la ville a bien été définie
if [ "$#" -ne 1 ]; then
    echo "Utilisation type : $0 VILLE"
    exit 1
fi

# Si ville est définie, on récupère l'argument dans une variable
VILLE="$1"

# Utiliser curl pour récupérer les données météo
curl -s "wttr.in/$VILLE?format=%t" > "meteo_$VILLE.txt"

# Vérification récupération réussie
if [ $? -eq 0 ]; then
    echo "Météo pour $VILLE sauvegardée dans meteo_$VILLE.txt"
else
    echo "Erreur : récupération des données impossible pour $VILLE"
    exit 1
fi

# Extraire la température actuelle (première ligne)
TEMP_ACTUELLE=$(head -n 1 "meteo_$VILLE.txt")

# Récupérer la prévision pour demain
TEMP_PREVISION=$(curl -s "wttr.in/$VILLE?format=%t" | tail -n 1)

# Afficher les résultats pour vérifier
echo "Température actuelle : $TEMP_ACTUELLE"
echo "Prévision pour demain : $TEMP_PREVISION"

# Enregistrer les températures dans un fichier
echo "$VILLE : Température actuelle : $TEMP_ACTUELLE, Prévision pour demain : $TEMP_PREVISION" >> meteo_$VILLE.txt

