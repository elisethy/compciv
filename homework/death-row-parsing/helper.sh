mkdir -p data-hold
cd data-hold
curl -o texas-list-present http://www.tdcj.state.tx.us/death_row/dr_offenders_on_dr.html
curl -o texas-list-1973 http://www.tdcj.state.tx.us/death_row/dr_list_all_dr_1923-1973.html
curl -o florida-death-row http://www.dc.state.fl.us/activeinmates/deathrowroster.asp
curl -o florida-execution-present http://www.dc.state.fl.us/oth/deathrow/execlist.html
curl -o florida-execution-1964 http://www.dc.state.fl.us/oth/deathrow/execlist2.html
curl -o california-inmate-list http://www.cdcr.ca.gov/capital_punishment/docs/condemnedinmatelistsecure.pdf
cd ~/compciv/homework/death-row-parsing

