# Vérification de l'argument (la ville)
if [ "$#" -lt 1 ]; then
    echo "Aucune ville spécifiée, Toulouse comme ville par défaut"
    VILLE="Toulouse"
else
    VILLE="$1"
fi

# Vérification de l'option JSON
FORMAT_JSON=false
if [ "$2" == "--json" ]; then
	FORMAT_JSON=true
fi

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
VITESSE_VENT=$(grep -o '"windspeedKmph":[^,]*' "meteo_$VILLE.txt" | head -n 1 | sed 's/[^0-9]*//g')
TAUX_HUMIDITE=$(grep -o '"humidity":[^,]*' "meteo_$VILLE.txt" | head -n 1 | sed 's/[^0-9]*//g')
VISIBILITE=$(grep -o '"visibility":[^,]*' "meteo_$VILLE.txt" |head -n 1 | sed 's/[^0-9]]*//g')

# 3. Affichage et formatage des températures récupérées
echo "Température actuelle : ${TEMP_ACTUELLE}°C"
echo "Vitesse du vent : ${VITESSE_VENT} km/h"
echo "Taux d'humidité : ${TAUX_HUMIDITE}%"
echo "Visibilité : ${VISIBILITE} km"
echo "Température prévue demain : ${TEMP_PREVISION}°C"

# 4. Enregistrer température actuelle et prévision du lendemain dans fichier meteo.txt ou le meteo.json
DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")

if [ "$FORMAT_JSON" = true ]; then
	NOUVELLE_ENTREE="{
		\"date\": \"$DATE\",
		\"heure\": \"$HEURE\",
		\"ville\": \"$VILLE\",
		\"temperature_actuelle\": \"${TEMP_ACTUELLE}°C\",
		\"temperature__prevision\": \"${TEMP_PREVISION}°C\",
		\"vitesse_vent\": \"${VITESSE_VENT} km/h\",
		\"humidite\": \"${TAUX_HUMIDITE}%\",
		\"visibilite\": \"${VISIBILITE} km\"
	}"
	rm "meteo_$VILLE.txt"
	if [ -f "meteo.json" ]; then
		sed -i '$ s/],$/],/' meteo.json
		echo ",$NOUVELLE_ENTREE]" >> meteo.json
	else
		echo "[$NOUVELLE_ENTREE]" > meteo.json
	fi
else
	echo "$DATE - $HEURE - Ville : $VILLE - Température actuelle : ${TEMP_ACTUELLE}°C - Vitesse du vent : ${VITESSE_VENT} km/h - Taux d'humidité : ${TAUX_HUMIDITE}% - Visibilité : ${VISIBILITE} km - Prévision du lendemain : ${TEMP_PREVISION}°C" >> meteo.txt
	rm "meteo_$VILLE.txt"

	# 5. Enregistrer en plus tout  ces informations dans des logs journaliers
	echo "$DATE - $HEURE - Ville : $VILLE - Température actuelle : ${TEMP_ACTUELLE}°C - Vitesse du vent : ${VITESSE_VENT} km/h - Taux d'humidité : ${TAUX_HUMIDITE}% - Visibilité : ${VISIBILITE} km -Prévision du lendemain : ${TEMP_PREVISION}°C" >> "meteo_$DATE.txt"
fi
