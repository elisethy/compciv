# This assignment is just for readability purposes
username=$1
# create data-hold if it doesn't already exist
mkdir -p ./data-hold
echo "Fetching tweets for $username into ./data-hold/$username-timeline.csv
"
# use t to download the tweets in CSV form and save to file
file=data-hold/$username-timeline.csv
t timeline -n 3200 --csv $username > $file
# Get the count of lines using csvfix and its order subcommand
# note: another subcommand could be used here, but the point is to use
# csvfix to reduce the file to just the first field, and then count the lines.

# In other words, you cannot just count the number of Tweets with wc alone, 
# because some tweets span multiple lines
count=$(csvfix order -f 1 $file | wc -l)
# The timestamp of the tweet is in the field (i.e. column) named, 'Posted at'
# and the oldest tweet is in the last line
lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)
# Echoing some stats about the tweets
echo "Analyzing $count tweets by $username since $lastdate"
echo "Top 10 hashtags by $username"
csvfix order -f 4 $file | grep -oE '#[[:alnum:]]+' | sort | uniq -c | sort -r | head -n 10
echo "Top 10 retweeted users by $username"
csvfix order -f 4 $file | grep -oE 'RT @[[:alnum:]]+' | grep -oE '@[[:alnum:]]+' | sort | uniq -c | sort -r | head -n 10
echo "Top 10 mentioned users (not including retweets) by $username"
csvfix order -f 4 $file | grep -v 'RT @[[:alnum:]]+' | grep -oE '@[[:alnum:]]+' | sort | uniq -c | sort -r | head -n 10
echo "Top 10 tweeted 10 words with 5+ letters by $username"
csvfix order -f 4 $file | sed -E 's/@[[:alnum:]]+//g' | grep -oE '[[:alnum:]]{5,}' | sort | uniq -c | sort -r | head -n 10
