pdftotext -layout data-hold/california-inmate-list data-hold/california-list-text

cat data-hold/california-list-text | grep -oE 'Living.+' | grep -oE '\b[A-Z]{3}\b' | sort
