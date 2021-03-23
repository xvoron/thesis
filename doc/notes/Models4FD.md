%title Decision models for Fault Detection and Diagnosis
%date

= Contents =
    - [[#General|General]]
    - [[#Feature selection|Feature selection]]
    - [[#Statical Distribution Fitting|Statical Distribution Fitting]]
    - [[#Machine learning|Machine learning]]

= General = 
For designing algorithms for condition monitoring we use condition
indicators extracted from measured or generate signals.

Designing an algorithm is iterative process when you try different
combinations of condition indicators and models.

= Feature selection =
Feature selection reduce condition indicators number to most relevant for
classification task purposes.
- pca
- squentialfs
- fscnca

= Statical Distribution Fitting =
Probability Distributions. TODO: have no idea
- ksdensity
- histfit
- ztest

= Machine learning =
Apply machine learning techniques to Fault Diagnosis. Classification task
easiest example.

- fitcsvm - binary classifier
- fitcecoc - multiple class classifier (but in backend binary classifier
  used)
- fitctree - binary decision tree
- fitclinear - for high-dimensional training data
- kmeans - minimizing distance

= Regression =
Create a model that describe your system in best way and after:
1. Collect simulated data from system
2. Identify model
3. Use clustering techniques
4. Collect new data in operation and identify a model of its behavior

Models:
- ssest
- arx, armax, ar
- nlarx

= Control Charts =
Statistical Process control techniques for measure, analyze, improve and
control production process.
- controlchart - visualize a control chart
- controlrules - define control rules
- cusum - Detect small changes in the mean value of data

= Changepoint Detection =
Track signal in time development and detect changes in trend.
- findchangepts - find changes in signals
- findpeaks
- pdist, pdist2, mahal - find distances
- segment - segment data and estimate using AR models for each segment.
