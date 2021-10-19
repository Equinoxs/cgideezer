#!/bin/bash

for i in ul/*.mp3; do
	ii=$(echo "$i" | sed -e "s/ul\///")
	FILE="ul/img/"$ii".jpg"
	if [ -f "$FILE" ]; then

    		echo "$FILE exists."
	else
		eyeD3 --write-images=./ul/img $i
		mv ./ul/img/FRONT_COVER.jpg ./ul/img/$ii.jpg
	fi
done

for i in ul/img/*.jpg
do
	mp3=$(echo "$i" | sed -e "s/.jpg//" | sed -e "s/img\///")
	echo $mp3
	if [ -f "$i" ]
	then
		if [ -f "$mp3" ]
		then
			echo "Fichier "$mp3" existe."
		else
			echo "suppression de "$i
			rm $i
		fi
	fi
done
