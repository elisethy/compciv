foldername=$(date '+%Y-%m-%d_%H00')
mkdir -p  data-hold/scrapes/$foldername
pathname="data-hold/scrapes/$foldername"
list=$(cat data-hold/OccupationalSeries.xml | \
 grep JobFamily | grep -oE '[0-9]{1,4}' | sort | uniq)


for seriesnum in $list; do
   curl -s -o "$pathname/$seriesnum-1.json" "https://data.usajobs.gov/api/jobs?NumberOfJobs=250&series=$seriesnum"
   echo "&series=$seriesnum&Page=1"
   totalpages=$(cat $pathname/$seriesnum-1.json | jq -r ".Pages")
   for page in $(seq 2 $totalpages); do
      curl -s -o "$pathname/$seriesnum-$page.json" "https://data.usajobs.gov/api/jobs?NumberOfJobs=250&series=$seriesnum&Page=$page"     
      echo "&series=$seriesnum&Page=$page"
   done
done
