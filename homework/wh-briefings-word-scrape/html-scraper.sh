cat data-hold/* |  pup '#content text{}' | tr '[[:upper:]]' '[[:lower:]]' | grep -oE '[[:alpha:]]{7,}' | sort | uniq -c | sort -r | head -n 10


