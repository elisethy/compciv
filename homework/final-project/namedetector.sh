datafile='data-hold/namesample.txt'

if [[ $# -eq 0 ]]; then
   echo "Please pass in at least one name"
else

for name in "$@"; do

name_matches=$(cat $datafile | grep -i "^$name,")

if [[ -z $name_matches ]]; then
  echo "NA"
else

m_count=0
f_count=0

for row in $name_matches; do
  babies=$(echo $row | cut -d ',' -f '3')
  if [[ $row =~ ',M,' ]]
    then    
      m_count=$((m_count + babies))
    else
      f_count=$((f_count + babies))
  fi      
done

total_babies=$((m_count + f_count))
pct_female=$((100 * f_count / total_babies))
pct_male=$((100-pct_female))

if [[ $pct_female -ge 50 ]]; then
  g="F"
else
  g="M"
fi

echo "$g"

fi

done
fi
