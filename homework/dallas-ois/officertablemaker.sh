cat data-hold/tables/incidents.psv | while read -r incident; do
 officers=$(csvfix order -sep "|" -smq -f 7)
   echo $officers | grep "Jr" | sed "s/\/M/\/M#/g" | sed "s/\/F/\/M#/g" | grep -oE "[^#]+" | tr -d '"' | while read -r officer; do
   first_name=$(echo $officer | sed s/Unknown/,Unknown/ | cut -d "," -f 2)
   last_name=$(echo $officer | sed s/Unknown/,Unknown/ | cut -d "," -f 1)
   echo "$first_name|$last_name"
   done
done


