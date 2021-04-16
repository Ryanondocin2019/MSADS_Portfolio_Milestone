# IST 718: Big Data Analytics

# Ryan Ondocin 

830726907

rjondoci@syr.edu

# Abstract
Social media has played an integral role in presidential elections since 2016; with the advent of Cambridge Analytica and nuanced psycho-political campaigning tactics. Twitter can be seen as a platform for candidates and users to gain substantial outreach to showcase their views to the world. Thus it is important to analyze and understand the role Twitter can play in gauging sentiment surrounding hot button issues that voters use in deciding which candidate is fit for leading the United States for the next four to eight years.

# Description
This project aimed to perform sentiment analysis on tweets about the 2020 US Presidential election for candidates Joe Biden and Donald Trump. Our objective was to unearth contrasting information both one week before and after the election results were announced. Using Principal Component Analysis (PCA) and KMeans clustering, we tried to analyze the presence of polarity or communities in the dataset. Furthermore, we performed a hashtag distribution analysis on our clusters to validate and inspect user sentiment. We applied Logistic Regression and Random Forest Classification to generate the top words, in terms of feature importance, responsible for predicting tweet sentiment and we looked for any change in the top words between these two time periods.

# Required Tools:
* Python 
* sklearn
* sklearn.manifold
* pandas
* numpy
* pySpark
* matplotlib
