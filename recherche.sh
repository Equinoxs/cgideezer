#!/bin/bash

export LANG=fr_FR.utf-8
echo -e "Content-type: text/html\n\n"
echo '<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Résultats de la recherche</title>
    <link rel="stylesheet" href="bulma/css/bulma.css">
  </head>
  <body>
  <script type="text/javascript">
  function choisi()
  {
    chargement = document.getElementById("load");
    resultat = document.getElementById("resultat");
    chargement.style.display="";
    resultat.style.display="none";
  }
  </script>
  <section class="section">
    <div class="container">
      <h1 class="title">
        Résultats de la recherche
      </h1>
  <div id="load" style="display: none;" class="box has-text-centered"><p class="title">Chargement...</p><img src="loading.gif"></div>
  <div class="columns" id="resultat">
  '

recherche=$(echo "$QUERY_STRING" | sed -e "s/recherche=//" | tr -d \')
#recherche="me gustas tu"
#echo "$recherche"

resultat=$(python3 recherche_titre-artiste.py $recherche)

#my_array=($(echo $resultat))


#resultat=$(echo "$resultat" | tr "\n" ";")
#IFS=';' read -a tableau_resultats <<< "$resultat"


#for i in {0..4}
#do
#  echo ${tableau_resultats[i]}
#done

echo "$resultat"

echo "</div>
</div>
</section>
</body>
</html>
"
