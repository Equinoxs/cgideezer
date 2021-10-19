#!/usr/bin/env python3

from deezer import Deezer
import sys

objetDeezer = Deezer()

arguments = ""

i = 0
while i < len(sys.argv):
	if sys.argv[i] != "recherche_titre-artiste.py":
		arguments += sys.argv[i]
		arguments += " "
	i += 1

# print("Recherche : ", arguments, "\n")

resultat = objetDeezer.api.search_track(arguments, limit=5)

# print(resultat)

i = 0

while i < len(resultat['data']):
    # print("<a onclick='return ray.ajax()' href='telechargement.sh?recherche=", arguments, "&index=", i, "'><div class='resultat'><img src='", resultat['data'][i]['album']['cover_big'], "'><p class='titre'>", resultat['data'][i]['artist']['name'], " - ", resultat['data'][i]['title'], " (",resultat['data'][i]['album']['title'], ")</p></div></a>", sep='')
	print('''
	<div class="column is-one-fifth">
<a onclick="choisi()" href="telechargement.sh?recherche=''', arguments, '''&index=''', i, '''">
<div class="card">
<div class="card-image">
  <figure class="image is-square">
	<img src="''', resultat['data'][i]['album']['cover_big'], '''">
  </figure>
</div>
<div class="card-content">
  <div class="media">
	  <div class="media-content">
		<p class="title is-4">''', resultat['data'][i]['title'], '''</p>
		<div class="subtitle">
		  <p>''', resultat['data'][i]['artist']['name'], '''</p>
		  <p>''', resultat['data'][i]['album']['title'], '''</p>
		</div>
	  </div>
  </div>
</div>
</div>
</a>
</div>
	''', sep='')
	i+=1
