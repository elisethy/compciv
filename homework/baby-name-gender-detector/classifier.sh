# this script expects `helper.sh` to have created a 
# file at ./data-hold/namesample.txt to use
datafile='data-hold/namesample.txt'

if [[ $# -eq 0 ]]; then
   echo "Please pass in at least one name"
else

for name in "$@"; do

# name=Elise

name_matches=$(cat $datafile | grep -i "^$name,")

if [[ -z $name_matches ]]; then
  echo "$name,NA,0,0"
else

m_count=0
f_count=0

# for each value in $name_matches
for row in $name_matches; do
  # get the baby count, which is in the third column, i.e.
  # Jessie,F,999
  # and set it to the `babies` variable
  babies=$(echo $row | cut -d ',' -f '3')
  if [[ $row =~ ',M,' ]]
    then    
      # if the row is for male babies,
      # add to $m_count
      # Note that in shell arithmetic, you don't have to use
      # the dollar sign to reference the variables
      m_count=$((m_count + babies))
    else
      f_count=$((f_count + babies))
  fi      
done
# The for-loop needed to sum up the babies is done

total_babies=$((m_count + f_count))
pct_female=$((100 * f_count / total_babies))
pct_male=$((100-pct_female))

# If the percentage is greater to or equal to 50
if [[ $pct_female -ge 50 ]]; then
  g_and_pct="F,$pct_female"
else
  g_and_pct="M,$pct_male"
fi


echo "$name,$g_and_pct,$total_babies"

fi


done
fi
