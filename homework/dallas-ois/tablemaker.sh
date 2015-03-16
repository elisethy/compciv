mkdir -p data-hold/tables
echo "case_number|date|location|suspect_status|suspect_weapon|suspects|officers|grand_jury|latitude|longitude|narrative"  > data-hold/tables/incidents.psv
cat data-hold/*.html | pup 'table table tr json{}' | 
  jq  --raw-output '.[] .children | [ 
    .[0] .children[0] .href, 
    .[0] .children[0] .text, 
    .[1] .text ,
    .[2] .text,
    .[3] .text,
    .[4] .text,
    .[5] .text,
    .[6] .text,
    .[7] .text
  ] | @csv' | grep -v 'Location' | \
    while read -r incident; do 

   addr=$(echo $incident | csvfix order -smq -f 4) 
   fname=$(echo $addr | tr ' ' '+' | tr -d '"')
   lat=$(cat data-hold/geocodes/$fname.json | jq '.results[0] .geometry .location .lat')
   lng=$(cat data-hold/geocodes/$fname.json | jq '.results[0] .geometry .location .lng')
   casepdf=$(echo $incident | csvfix order -smq -f 1)
   narrative_pdf="data-hold/pdfs/$(basename $casepdf)"
   pdftotext $narrative_pdf
   narrative=$(cat "data-hold/pdfs/$(basename $narrative_pdf '.pdf').txt" | tr '[:space:]' ' ')

   echo "$(echo $incident | csvfix echo -osep '|')|$lat|$lng|$narrative" >> data-hold/tables/incidents.psv
done  

echo "case_number|date|suspect_killed|suspect_weapon|last_name|first_name|race|gender" > data-hold/tables/officers.psv
echo "case_number|date|suspect_weapon|last_name|first_name" > data-hold/tables/suspects.psv
cat data-hold/tables/incidents.psv | while read -r incident; do
  officers=$(csvfix order -smq -f 7)
  echo "$officers"
done

