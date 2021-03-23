%title Remaining useful life prediction
%date

= Contents =
    - [[#Basics|Basics]]
    - [[#Models for RUL|Models for RUL]]
    - [[#RUL Estimation|RUL Estimation]]
        - [[#RUL Estimation#Identified/State Models|Identified/State Models]]
        - [[#RUL Estimation#RUL Estimator Models|RUL Estimator Models]]
        - [[#RUL Estimation#Choose RUL Estimator|Choose RUL Estimator]]

= Basics =
We need to evaluate a CI that connected with system degradation process.
Remaining useful life is expected time remaining before the machine
requires repair or replacement. It's a central goal of PM.

Features metrics for RUL:
- monotonicity: Monotonic positive or negative trend
- trendability: ???
- prognosability: is a measure of the variability of a feature at
  failure???

= Models for RUL =
Time evaluation and statistical properties:
- Models that fits the time evaluation and predicts how long it will be
  before CI cross some threshold.
- Models that compares the time evaluation of CI to measured or simulated
  time series from systems that ran to failure.

Statistical estimators:
- Dynamic models from "System Identification Toolbox".
- PM Toolbox models.


= RUL Estimation =
== Identified/State Models ==
We can use identified model to predict feature behavior of a system. This
model can be identified from measured system data.
We have another option to extract condition indicators from the measured
data and track the behavior of the condition indicators with time or usage.
Then we can identify a model that describes behavior of the condition
indicators and use that model to predict future values of a condition
indicators.

1. Model dynamic:
    1. Identify a dynamic model
    2. Predict future behavior of dynamics
2. Extract CI from data:
    1. Identify model that describes the behavior of the CI
    2. Predict future of the CI

Dynamic models identification:
- ssest - state-space estimator
- arx, armax, ar - autoregressive models
- nlarx - Nonlinear models such as wavelet networks, tree-partitioning ...

For predict future behavior *forecast* function can be used.
For real-time application *recusiveARX* and *recursiveAR* can be used.

RUL estimation with state estimators works in similar way:
- unscentedKalmanFilter
- extendedKalmanFilter
- particleFilter

== RUL Estimator Models ==
For using PM Toolbox includes some specialized designed for computing RUL
from different types of measured system data. This models are useful when
you have:
- Run-to-failure histories of system
- A known threshold value for CI that indicates failure
- Lifetime: data about how much time it took for similar systems to fail

General workflow:
1. Create and configure best model type for your application
2. Train the model using historical data, (`fit` command)
3. Using test data to estimate the RUL or recursively update (`predictRUL`,
   `update`)

== Choose RUL Estimator ==
Based on data we can chose 3 main model types:
- Similarity Models: Run-to-failure data
- Degradation Models: Based on CI and their degradation threshold
- Survival Models: Life time data


