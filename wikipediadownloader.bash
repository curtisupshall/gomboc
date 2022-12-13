#!/bin/bash
# Usage
# $ ./wikipediadownloader.bash <name of category in url> <output directory>

set -x

echo a > next

category=$1
outputdirectory=$2

out=$(curl -A "CategoryDownloader/0.1 (cchurla@uvic.ca) cURL/7.79.1"\
    'https://commons.wikimedia.org/w/api.php?action=query&format=json&prop=imageinfo&generator=categorymembers&iiprop=url&gcmtype=file&gcmlimit=500&gcmtitle=Category%3A+'$category)

file=$(echo $out | jq -r '.continue.gcmcontinue')

while test $file != 'null' ; do
    echo $out | jq -r '.query.pages | to_entries[] | .value.imageinfo[0].url' | xargs -L1 wget \
        --user-agent="CategoryDownloader/0.1 (cchurla@uvic.ca) gnuwget/1.21.3" \
        -P $outputdirectory/
    out=$(curl 'https://commons.wikimedia.org/w/api.php?action=query&format=json&prop=imageinfo&generator=categorymembers&iiprop=url&gcmcontinue='$file'&gcmlimit=500&gcmtitle=Category%3A+'$category)
    file=$(echo $out | jq -r '.continue.gcmcontinue')
done

echo Done!

