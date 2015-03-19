female_count=0
male_count=0
female="F"
male="M"
for line in $(cat data-hold/*/*.json | jq -r '.response .docs[] | select(.print_page == "1") .byline .person[] .firstname'); do
    gender=$(bash namedetector.sh $line)
    if [ $gender == $female ]; then
       female_count=$((female_count + 1))
    fi
    if [ $gender == $male ]; then
       male_count=$((male_count + 1))
   fi
done

echo "$female_count women and $male_count men were featured on the front page between $1 and $2"
