#!/bin/bash

export LANG=fr_FR.utf-8
echo -e "Content-type: text/html\n\n"
tri=$(echo "$QUERY_STRING" | sed -e "s/tri=//" | tr -d \')

taille=$(du -sh0 ../)
taille=${taille%	*}

echo '<!DOCTYPE html>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Musique !</title>
    <link rel="stylesheet" href="bulma/css/bulma.css">
    <style media="screen">
      audio
      {
        width: 100%;
      }
    </style>
  </head>
  <body>
    <script type="text/javascript">
      var i = 0;
      function target_popup(form)
      {
        globalThis.fenetre = window.open("", i, "width=1280,height=800");
        form.target = i;
        fenetre.moveTo(i * 100, 100);
        fenetre.focus();
        i++;
        var timer = setInterval(function() {
          if(fenetre.closed) {
            clearInterval(timer);
            window.location.reload();
          }
        }, 1000);
      }
    </script>
    <section class="section">
      <div class="container">
        <h1 class="title">
          Musique ('$taille' utilisés sur 200M)
        </h1>
        <details>
          <summary class="subtitle">Affichage</summary>
          <summary class="box">
            <h1 class="subtitle"><u>Affichage</u></h1>
            <form action="#">
              
'
if [ $tri == "date" ]
then
echo '<input type="radio" id="date" name="tri" value="date" checked="">
<label for="date">Date de téléchargement</label><br>
<input type="radio" id="nom_artiste" name="tri" value="nom_artiste">
<label for="nom_artiste">Nom d&apos;artiste (défaut)</label>'
else
echo '<input type="radio" id="date" name="tri" value="date">
<label for="date">Date de téléchargement</label><br>
<input type="radio" id="nom_artiste" name="tri" value="nom_artiste" checked="">
<label for="nom_artiste">Nom d&apos;artiste (défaut)</label>'
fi
echo '
<br><br>
<input type="submit" style="box-sizing: revert;" class="button is-primary">
</form>
</summary>
<br>
</details>
<div class="box">
<form action="recherche.sh" method="get" onsubmit="target_popup(this);" class="form">
<div class="field">
<label class="label">Rechercher une musique et la télécharger</label>
<div class="control">
<input class="input" type="text" placeholder="Recherche" name="recherche">
</div>
</div>
<input type="submit" class="button is-primary">
</form>
</div>

<div class="columns is-multiline">
'
if [ $tri == "date" ]
then
	resultat=$(ls -t ul/)
	resultat=$(echo "$resultat" | tr "\n" ";")
	IFS=';' read -a tableau_resultats <<< "$resultat"
	for i in ${tableau_resultats[*]}
	do
		if [ $i != "img" ]
		then
			nomFichierSansUl=$i
			i="ul/"$i
			#echo "<div class='chanson'><img class='imageChanson' src='ul/img/"$nomFichierSansUl".jpg'><p class='texte'><a href='"$i"'>" $(/bin/mediainfo --inform="General;%Title%" $i) " - " $(mediainfo --inform="General;%Performer%" $i) "</a><br><audio controls><source src='"$i"' type='audio/mpeg'></audio><br><a href='dl.sh?fichier="$nomFichierSansUl"'>[Télécharger "$nomFichierSansUl"]</a><br><a href='rm.sh?fichier="$nomFichierSansUl"' onclick='return ray.ajax()'>[Supprimer "$nomFichierSansUl"]</a></p></div>"
      echo '
      <div class="column is-one-third">
        <div class="card">
          <div class="card-image">
            <figure class="image is-square">
              <img src="ul/img/'$nomFichierSansUl'.jpg">
            </figure>
          </div>
          <div class="card-content">
            <div class="media">
              <a href="'$i'">
                <div class="media-content">
                  <p class="title is-4">'$(/bin/mediainfo --inform="General;%Title%" $i)'</p>
                  <p class="subtitle is-6">'$(/bin/mediainfo --inform="General;%Performer%" $i)'</p>
                </div>
              </a>
            </div>
            <p>
              <audio controls><source src="'$i'" type="audio/mpeg"></audio>
                </p>
            </div>
            <footer class="card-footer">
              <a href="dl.sh?fichier='$nomFichierSansUl'" class="card-footer-item">Télécharger</a>
              <a href="rm.sh?fichier='$nomFichierSansUl'" class="card-footer-item">Supprimer</a>
            </footer>
          </div>
      </div>
      '
		fi
	done
else
for i in ul/*.mp3; do
	nomFichierSansUl=$(echo "$i" | sed -e "s/ul\///")
	#echo "<div class='chanson'><img class='imageChanson' src='ul/img/"$nomFichierSansUl".jpg'><p class='texte'><a href='"$i"'>" $(/bin/mediainfo --inform="General;%Title%" $i) " - " $(mediainfo --inform="General;%Performer%" $i) "</a><br><audio controls><source src='"$i"' type='audio/mpeg'></audio><br><a href='dl.sh?fichier="$nomFichierSansUl"'>[Télécharger "$nomFichierSansUl"]</a><br><a href='rm.sh?fichier="$nomFichierSansUl"' onclick='return ray.ajax()'>[Supprimer "$nomFichierSansUl"]</a></p></div>"
  echo '
  <div class="column is-one-third">
    <div class="card">
      <div class="card-image">
        <figure class="image is-square">
          <img src="ul/img/'$nomFichierSansUl'.jpg">
        </figure>
      </div>
      <div class="card-content">
        <div class="media">
          <a href="'$i'">
            <div class="media-content">
              <p class="title is-4">'$(/bin/mediainfo --inform="General;%Title%" $i)'</p>
              <p class="subtitle is-6">'$(/bin/mediainfo --inform="General;%Performer%" $i)'</p>
            </div>
          </a>
        </div>
        <p>
          <audio controls><source src="'$i'" type="audio/mpeg"></audio>
            </p>
        </div>
        <footer class="card-footer">
          <a href="dl.sh?fichier='$nomFichierSansUl'" class="card-footer-item">Télécharger</a>
          <a href="rm.sh?fichier='$nomFichierSansUl'" class="card-footer-item">Supprimer</a>
        </footer>
      </div>
  </div>
  '
done
fi
echo '</div>
</div>
</section>
</body>
</html>'
