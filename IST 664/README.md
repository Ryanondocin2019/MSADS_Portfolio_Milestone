# Ryan Ondocin 

830726907
rjondoci@syr.edu

# Covid-tweet-textual-clustering-kmeans
Used K-means and t-SNE to visually represent the transmission of COVID-19 tweets over a given time frame. An interactive Bokeh plot was created to explore and investigate the transmission of textually based COVID-19 clusters. Link to plot is available at: https://ryanondocin2019.github.io/

# Abstract
Given the vast influx of information surrounding the COVID-19 pandemic and its exponential
transmission via various social networking platforms, it is difficult for users to coherently
process all of the surrounding buzz. Social media sites such as Facebook and Twitter generate
ad-revenue based on user engagement, which allows for rumors and misinformation to spread
like wildfire. Due to the broad scope and lack of relevantly labeled data, we will not focus on
identifying misinformation. Instead, we will attempt to give the user a new point-of-reference for
digesting social media.
By topically clustering tweets via the use of a variety of NLP and ML techniques, we will offer a
new lens into the COVID-19 pandemic that can help users digest information in a much simpler
manner. The interactive bokeh plot we create will aid in understanding the information dynamics
between Twitter users and the coronavirus. Disclaimer : Our modeling process was inspired by a
publication on Covid-19 Literature Clustering. [3] Many of our ideas were molded from their
works on health-care literature made available in the COVID-19 Research Dataset Challenge on
Kaggle.
For this project, we will cover the following:
* Web scraping and Data
* Preprocessing and Feature Engineering
* Sentiment Analysis TextBlob (brief insight)
* SpaCy tokenization
* Vectorization (TF-IDF/BOW) and Dimensionality reduction via PCA
* K-means clustering model (validation and visualization)
* Bokeh plot
We hope you enjoy this exploration.

# Required Tools:
* Python 
* Bokeh
* SpaCy
* sklearn
* tweepy
* pandas
* numpy
* matplotlib
