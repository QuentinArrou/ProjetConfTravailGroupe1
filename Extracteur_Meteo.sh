# Vérification de l'argument (la ville)
if [ "$#" -ne 1 ]; then
    echo "Utilisation type: $0 VILLE"
    exit 1
fi

# Si ville est dfinie on rcupère l'argument dans une variable
VILLE="$1"


# 1. Récupérer les données météorologiques avec la commande curl puis les sauvegarder dans un
#fichier local "VILLE.txt".
echo "Récupération des données pour la ville : $VILLE"
curl -s "wttr.in/$VILLE?format=j2" > "meteo_$VILLE.txt"

#Vérifier si la récupration est réussie
if [ $? -eq 0 ]; then
	echo "Météo pour $VILLE sauvegardée dans meteo_$VILLE.txt"
else
	echo "Erreur : récupération des données impossible pour $VILLE"
	exit 1
fi

# 2. Extraire du fichier la température actuelle et la prévision pour le lendemain
TEMP_ACTUELLE=$(grep -o '"temp_C":[^,]*' "meteo_$VILLE.txt" | head -n 1 | sed 's/[^0-9\-]*//g')
TEMP_PREVISION=$(grep -o '"avgtempC":[^,]*' "meteo_$VILLE.txt" | sed -n '2p' | sed 's/[^0-9\-]*//g')

# 3. Affichage et formatage des températures récupérées
echo "Température actuelle : ${TEMP_ACTUELLE}°C"
echo "Température prévue demain : ${TEMP_PREVISION}°C"
