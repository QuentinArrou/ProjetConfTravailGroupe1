#!/bin/bash

# Verification que la ville a bien été définie
if [ "$#" -ne 1 ]; then
	echo "Utilisation type : $0 VILLE"
	exit 1
fi

# Si ville est définie on récupère l'agument dans une variable
VILLE="$1"

# Utilise commande curl pour récupérer les données météo
curl -s "wttr.in/$VILLE" > "meteo_$VILLE.txt"

# Verification récupération réussie
if [ $? -eq 0 ]; then
	echo "Météo pour $VILLE sauvergardée dans meteo_$VILLE.txt"
else
	echo "Erreur : recuperation des données impossible pour $VILLE"
fi
