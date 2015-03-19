### THIS IS THE MASTER SCRIPT WHICH CALLS EVERYTHING ELSE
### Takes in two arugments in this format for dates: YYYYMMDD
### The second date must fall after the first date, and within the same month
### Downloading may take some time!

bash helper.sh

baseurl="http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=source.contains%3A%28%22New+York%22%29&begin_date=BEGIN_DATE&end_date=END_DATE&sort=oldest&page=PAGE_NUM&api-key=5e617ac6cb5256d96fe3488d3d6a25f2:8:39721034"
begin_date=$1
end_date=$2
for day in $(seq $begin_date $end_date); do
   url=$(echo "$baseurl" | sed "s/END_DATE/$day/" | sed "s/BEGIN_DATE/$day/" | sed "s/PAGE_NUM/0/")
   mkdir -p data-hold/$day
   curl -sS "$url" -o "data-hold/$day/0.json"
   echo "downloading pages for $day"
   hits=$(cat "data-hold/$day/0.json" | jq '.response .meta .hits')
   first_page=1
   last_page=$((hits / 10))
   for pg in $(seq $first_page $last_page); do
      pageurl=$(echo "$url" | sed "s/page=0/page=$pg/")
      curl -sS "$pageurl" -o "data-hold/$day/$pg.json"
      echo "dowloading $pg of $last_page for $day"
    done
done

bash counter.sh $begin_date $end_date

