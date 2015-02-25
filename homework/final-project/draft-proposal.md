Final Project: New York Times Gender Detector

Overview:
The front page of the New York Times is the pinnacle of achievement for many journalists.
I'm curious what the gender breakdown over time of the front page is, but it is far too lengthy a problem to solve by hand.
I anticipate that men are more likely to be featured on the NYT home page.
This project will build off the baby names assignment, using the gender detector to estimate the male:female ratio of NYT bylines.
By combining this script  with one that parses the NYT API, my final product will calculate the gender ratio of male:female reporters.
The NYT API is in JSON format, so I can use jq to parse the "byline" element.
One of the available APIs is the "Top Stories" featured on the home page each day, which limits my search to "front page" articles.
If I decide to expand the scope of this project, an interesting parameter to add would be article section.
Are there more male bylines in business and female bylines in Style?  I'd be curious about that as well.

Technical Overview:
The script will take in a range of dates as a parameter, iterating through the selected dates and parsing for author names in the  byline.
The names will be fed into another script that uses the baby names algorithm to estimate gender based on US Census data.
If a name is 50% or more likely to be male or female, it will be added to the appropriate category.
Once the script has itered through each article, the output produced will be the number of male bylines versus the number of female bylines.

Justification:
This is an example of useful automation because it automates by collecting bylines and judging gender.
If I were to do this myself for even a month's worth of articles, it would be very time-consuming.
