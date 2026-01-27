## 🌐 Lien de l’application  

👉 www.mercerie-inventaire.com  

## 📦 Mercerie Inventaire  

Application web de gestion de stock développée avec Ruby on Rails pour centraliser et organiser des fournitures de couture : catégories, fiches fournitures, suivi de stock et liste d’achats.

---

## 🧠 Objectif

Projet réalisé dans un cadre d’apprentissage autodidacte afin d’approfondir Ruby on Rails, la gestion de base de données et l’authentification.  
L’objectif de cette application web est de gérer ses fournitures afin d’éviter les doublons, gagner du temps et garder un inventaire clair et accessible à tout moment.

Ce projet m’a permis de travailler sur :  
- les relations entre modèles  
- la persistance des données avec PostgreSQL  
- l’authentification sécurisée avec Devise  
- la mise en place d’un back-office avec RailsAdmin  

---

## ⚙️ Stack technique

**Back-end :**  
- Ruby on Rails  
- Devise (authentification)  
- RailsAdmin (back-office)  
- PostgreSQL  

**Front-end :**  
- ERB  
- Bootstrap  
- Stimulus  

**Outils & Hébergement :**  
- Heroku  
- Git / GitHub  
- VS Code  
- Trello  

---

## 💡 Fonctionnalités principales

- Gestion des fournitures  
  (quantité, unité, couleur, description)  

- Gestion des catégories  
  (création / édition / suppression)  

- Suivi des stocks bas  

- Liste d’achats  
  (ajout, retrait et mise à jour rapide)  

- Authentification sécurisée  
  (Devise)  

- Back-office admin  
  (RailsAdmin)  

---

## 🚀 Installation en local

git clone https://github.com/Benalta7892/MercerieInventaire.git
cd MercerieInventaire
bundle install
rails db:create db:migrate db:seed
rails server
http://localhost:3000

## 🌐 Lien de l’application  

👉 www.mercerie-inventaire.com  


Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
