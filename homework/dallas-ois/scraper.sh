mkdir -p data-hold
mkdir -p data-hold/pdfs
url="http://www.dallaspolice.net/ois"
curl $url/ois.html -s -o data-hold/ois_2014.html
for num in $(seq 2003 2012); do
	filename="ois_$num.html"
	curl "http://www.dallaspolice.net/ois/$filename" -s -o "data-hold/$filename"
done

# run other scraper to download pdfs
