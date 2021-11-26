Que fait ce pipeline?

Quand le code est poussé sur le repo dev(dev-repo) cela declenche la mise en marche de cloudbuild. Cloud build va créer un nouveau conteneur, va le pousser dans container registry et modifier le nom du conteneur dans le template kubernetes.yaml.tpl. Par la suite cloud build va cloner le repo prod(prod-repo) et va faire une copie du fichier kubernetes.yaml.tpl sous le nom kubernetes.yaml. Ensuite il va pousser ce fichier(kubernetes.yaml) dans le repo prod. Cela va déclencher un autre cloud build qui aura pour but de deployer le fichier kubernetes.yaml sur le cluster gke.

