mkdir -p data-hold/geocodes
cat data-hold/*.html | pup 'table table tr json{}' |    jq  --raw-output '.[] .children | [ 
    .[0] .children[0] .href, 
    .[0] .children[0] .text, 
    .[1] .text ,
    .[2] .text,
    .[3] .text,
    .[4] .text,
    .[5] .text,
    .[6] .text,
    .[7] .text
  ] | @csv' | csvfix order -smq -f 4 | grep -v 'Location' |  while read -r row; do

  fname=$(echo $row  | tr ' ' '+' | tr -d '"')
  addr=$(echo $fname Dallas TX | tr ' ' '+')
  echo $addr
  googleaddr="https://maps.googleapis.com/maps/api/geocode/json?address=$addr"
  curl -s $googleaddr > data-hold/geocodes/$fname.json
  sleep 3
 done
