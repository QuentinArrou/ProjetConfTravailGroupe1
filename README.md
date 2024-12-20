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

./Extracteur_Meteo.sh [Ville]

Par default le format utilisé est le format txt qui enregistre les donnees dans meteo.txt et dasn un log journalier cependant il est également possible de l'enregistrer au format json dans meteo.json en rajoutant l'argument --json après la ville souhaitée :

./Extracteur_Meteo.sh [Ville] --json 


## Configuration d'une Tâche Cron pour l'Automatisation des Données Météo

 Cette tache  permet d'automatiser la récupération des données météo à intervalles réguliers en ajoutant automatiquement une nouvelle ligne dans le fichier meteo.txt à chaque exécution de la tâche cron. Chaque ligne contient les informations suivantes : date, heure, ville, température actuelle, et température prévue. Cela permet de conserver un historique consultable des données.
Pour configurer la tâche, ouvrez le fichier crontab avec la commande suivante dans le terminal: **crontab -e**


- **Ouvrir le Crontab** : Pour configurer la tâche, ouvrez le fichier crontab avec la commande suivante dans le terminal .


- **Ajouter la Tâche Cron** : Ajoutez une ligne dans le crontab pour exécuter le script à l'intervalle souhaité . Voici quelques exemples .


- **Exécuter le script toutes les minutes** :

 ```* * * * *``` /Users/allaminemahamatatham/Projet_Config_groupe1/Extracteur_Meteo.sh
Cette ligne exécute le script toutes les minutes, ajoutant une nouvelle ligne dans meteo.txt avec les informations météo au moment de l'exécution

- **Exécuter le script toutes les 30 minutes** : ```*/30 * * * *```**/Users/allaminemahamatatham/Projet_Config_groupe1/Extracteur_Meteo.sh**.


- **Exécuter le script tous les jours à 8h du matin** : ```0 8 * * *```**/Users/allaminemahamatatham/Projet_Config_groupe1/Extracteur_Meteo.sh**.

Chaque ligne est constituée des informations de planification (par exemple,``` * * * * *``` pour chaque minute), suivie du chemin vers le script et  conserver un historique.


- **Enregistrer et Quitter le Crontab** : Après avoir ajouté la ligne pour planifier l'exécution du script, enregistrez et quittez l’éditeur. La tâche sera automatiquement programmée pour s'exécuter aux intervalles spécifiés.

- **Vérifier le Bon Fonctionnement de la Tâche** :  Pour vous assurer que la tâche cron fonctionne correctement, vous pouvez consulter le fichier meteo.txt pour voir si de nouvelles lignes y sont ajoutées aux intervalles planifiés. Utilisez la commande suivante pour surveiller les ajouts en temps réel :
**tail -f /Users/allaminemahamatatham/Projet_Config_groupe1/meteo.txt**.
Chaque exécution du script devrait générer une nouvelle entrée avec les données météo, ce qui indique que le script fonctionne bien.
