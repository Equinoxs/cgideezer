#!/bin/bash


recherche=$(echo "$QUERY_STRING" | sed -e "s/recherche=//" | tr -d \')
recherche=${recherche%&*}

index=${QUERY_STRING#*&}
index=${index#*=}

#echo "$recherche"
#echo "$index"

resultat=$(python3 recherche_lien.py $recherche)

resultat=$(echo "$resultat" | tr "\n" ";")
IFS=';' read -a tableau_resultats <<< "$resultat"


url=${tableau_resultats[index]}

#url="https://www.deezer.com/track/54519701"

python3 -m deemix "$url" -b 320 -p ul/ &> /dev/null

cd ul
for i in *.mp3; do
   nouveauNom=$(echo "$i" | tr -d "(")
   nouveauNom=$(echo "$nouveauNom" | tr -d ")")
   nouveauNom=$(echo "$nouveauNom" | tr -d "!")
   nouveauNom=$(echo "$nouveauNom" | tr " " "_")
   nouveauNom=$(echo "$nouveauNom" | tr -d \')
   mv "$i" "$nouveauNom"
done

rm -r *.lrc -f &

dernierFichierCree=$(find . -type f -exec stat -c '%Y %n' {} \; | sort -nr | awk 'NR==1,NR==1 {print $2}')

cd ~/www
#cd /opt/lampp/htdocs/musique
bash mkImg.sh &> /dev/null

echo -e "Content-type: text/html\n\n"

echo '<!DOCTYPE html>
<html lang="fr" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Téléchargement</title>
  </head>
  <body onload="window.close()">
  </body>
</html>
'

