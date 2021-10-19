#!/usr/bin/env python3

from deezer import Deezer
import sys

objetDeezer = Deezer()

arguments = ""

i = 0
while i < len(sys.argv):
	if sys.argv[i] != "recherche_lien.py":
		arguments += sys.argv[i]
		arguments += " "
	i += 1

# print("Recherche : ", arguments, "\n")

resultat = objetDeezer.api.search_track(arguments, limit=5)

# print(resultat)

i = 0

while i < len(resultat['data']):
    # print(resultat['data'][i]['artist']['name'], " - ", resultat['data'][i]['title'], " - ", resultat['data'][i]['link'])
    print(resultat['data'][i]['link'])
    i+=1
