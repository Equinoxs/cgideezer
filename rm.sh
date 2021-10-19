#!/bin/bash
export LANG=fr_FR.utf-8
cd ul

fichier=$(printf '%b\n' "${QUERY_STRING//%/\\x}" | sed -e "s/fichier=//")
#fichier="Bakermat_-_Baianá.mp3"

rm $fichier

echo -e "Location: index.sh\n\n"
