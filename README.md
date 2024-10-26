# Projet Météo Groupe 1 Configuration d'un Poste de Travail

## Présentation

Ce projet a pour objectif de développer un script Shell qui permet d'extraire et d'afficher les données météorologiques pour une ville donnée, en utilisant le service en ligne **wttr.in**. Grâce à ce script, les utilisateurs peuvent facilement consulter la température actuelle ainsi que les prévisions météorologiques pour le lendemain, directement dans leur terminal.

## Fonctionnalités

- **Récupération des données** : Utilisation de `curl` pour interroger l'API de wttr.in, ce qui permet d'obtenir les données météorologiques en temps réel pour une ville spécifiée.
  
- **Extraction des informations** : Le script extrait la température actuelle et la prévision pour le lendemain à partir des données récupérées, garantissant que les utilisateurs ont accès à des informations précises et à jour.
  
- **Formatage des données** : Les informations récupérées sont formatées de manière lisible, incluant la date, l'heure, le nom de la ville, la température actuelle et la prévision pour le lendemain.

- **Sauvegarde des résultats** : Les informations sont enregistrées dans un fichier texte (meteo.txt) pour une consultation future.

## Utilisation

Pour exécuter le script, ouvrez un terminal et utilisez la commande suivante :

