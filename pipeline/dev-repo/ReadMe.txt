Description

1- Dockerfile
    Ce fichier contient toutes les étapes à suivre pour créer un conteneur

2- Cloudbuild.yaml
    Ce fichier contient toutes les étapes de la CI
    NB: le compte de service cloudbuild doit avoir les droits d'écriture sur les répertoires(repos)

3- kubernetes.yaml.tpl
    Ce fichier est un template kube qui sera automatiquement mis à jour à chaque création d'un conteneuravant d'être exécuter sur le cluster kube
    
4- main.tf
    Ce fichier contient la déclaration des ressources à utilser
    NB: Pensez à modifier toutes valeurs modifiables tels que le project, credentials, region etc.
    
5- app.py
    Ce fichier contient un simple code python
