url="http://www.dallaspolice.net"
for pdf in $(cat data-hold/*.html | pup 'table td:nth-of-type(1) a attr{href}' | grep 'pdf'); do
      filename=$(echo $pdf | cut -d '/' -f 6)
      curl "$url$pdf" -s -o "data-hold/pdfs/$filename"

#echo "$url$pdf"

done



