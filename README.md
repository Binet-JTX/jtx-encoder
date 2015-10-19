Encodeur du JTX
===============

Ce petit script batch très portable offre toutes les fonctionnalités d'encodage nécessaires à un JTXman.

##Instructions

* Placer `JTX-Encoder.exe` dans le dossier contenant les vidéos à encoder et l'exécuter.
* Alternativement, on pourra utiliser `JTX-Encoder.bat` et `ffmpeg.exe` (version supérieure à 2.7.2)
* Suivre les instructions à l'écran et profiter !

##Fonctionnalités

Le programme dispose de deux modes de fonctionnement :
* soit il encode tous les fichiers vidéos du dossier en cours ;
* soit il encode récursivement tous les rushes (.MXF, .MVI, .MP4, .MTS, .MOV) du dossier courant et de ses sous-dossiers.

Les formats possibles d'encodage sont les suivants :
* FullHD   : 1920x1080 10 Mbits/s  25 i/s
* HD       : 1280x720  3 Mbits/s   25 i/s
* Web      : 854x480   1.5 Mbits/s 25 i/s
* Archives : 720x576   1.5 Mbits/s 25 i/s


##Remarques

* Pour que le programme marche correctement, il faut que le dossier en cours donne les droits d'exécution par défaut aux nouveaux fichiers. Ainsi il faut effectuer un `chmod +x *` dans le dossier d'exécution sur les serveurs du JTX.
* Lors de l'éxecution, un fichier `ffmpeg.exe` apparaîtra dans le dossier. Il sera supprimé à la fin de l'encodage, sauf si le programme ne s'est pas terminé correctement (ce qui est le cas quand on ferme manuellement la fenêtre de la console).