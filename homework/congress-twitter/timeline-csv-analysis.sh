username=$1
mkdir -p ./data-hold
echo "Fetching tweets for $username into ./data-hold/$username-timeline.csv"
file=data-hold/$username-timeline.csv
t timeline -n 3200 --csv $username > $file
count=$(csvfix order -f 1 $file | wc -l)
lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)
echo "Analyzing $count tweets by $username since $lastdate"
echo "Top 10 hashtags by $username"
csvfix order -f 4 $file | grep -oE '#[[:alnum:]]+' | sort | uniq -c | sort -r | head -n 10
echo "Top 10 retweeted users by $username"
csvfix order -f 4 $file | grep -oE 'RT @[[:alnum:]]+' | grep -oE '@[[:alnum:]]+' | tr '[[:upper:]]' '[[:lower:]]' | sort | uniq -c | sort -r | head -n 10
echo "Top 10 mentioned users (not including retweets) by $username"
csvfix order -f 4 $file | grep -v 'RT @[[:alnum:]]+' | grep -oE '@[[:alnum:]]+' | tr '[[:upper:]]' '[[:lower:]]' | sort | uniq -c | sort -r | head -n 10
echo "Top 10 tweeted 10 words with 5+ letters by $username"
csvfix order -f 4 $file | sed -E 's/@[[:alnum:]]+//g' | grep -oE '[[:alnum:]]{5,}' | tr '[[:upper:]]' '[[:lower:]]' | sort | uniq -c | sort -r | head -n 10
