cat data-hold/florida-death-row data-hold/florida-execution-present data-hold/florida-execution-1964 | \
pup 'td:nth-of-type(3) text{}' | grep -oE '[A-Z][A-Z]'

