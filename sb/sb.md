%title Signal based PM

= Contents =
    - [[#NEW|NEW]]
    - [[#Divide dataset|Divide dataset]]
    - [[#Preprocessing|Preprocessing]]
    - [[#FaultCodes Notes|FaultCodes Notes]]
    - [[#Sensors|Sensors]]
        - [[#Sensors#Microphones|Microphones]]
    - [[#Notes 27.4|Notes 27.4]]
    - [[#Encoder|Encoder]]
        - [[#Encoder#Small Dataset|Small Dataset]]
        - [[#Encoder#Full dataset|Full dataset]]
        - [[#Encoder#Conclusion|Conclusion]]
    - [[#Proximity sensors|Proximity sensors]]
        - [[#Proximity sensors#Conclusion|Conclusion]]
    - [[#Flow sensor|Flow sensor]]
        - [[#Flow sensor#Conclusion|Conclusion]]
    - [[#Pressure|Pressure]]
        - [[#Pressure#Conclusion|Conclusion]]
    - [[#Acc|Acc]]
    - [[#Conclusion|Conclusion]]
    - [[#Mic|Mic]]
        - [[#Mic#Full dataset|Full dataset]]
    - [[#Strain Gauge|Strain Gauge]]
        - [[#Strain Gauge#Conclusion|Conclusion]]

= NEW =

sequence2sequence classification using Deep Learning
[[https://www.mathworks.com/help/deeplearning/ug/sequence-to-sequence-classification-using-deep-learning.html]]

= Divide dataset =
train - 70 % 
validation - 15 %
test - 15 %

= Preprocessing =
Preprocessing signals?
Preprocess signals but without fanatismus :)
[[../doc/notes/signal_process.md]]


= FaultCodes Notes =

XXX FaultCode: 1100818
SmallDamper_bottom = 8
Anomalie ve vrchnim damperu. Urcite to bude nejaky problem

* What to do with data?
- Nothing for that but it must be solved in near feature !

= Sensors =
- [[../doc/sensors/sensors]]: All sensors comparison table

== Microphones ==
Cheapest sensor
* [ ] Time domain:
* [ ] Frequency domain:
* [ ] Time-Frequency domain ???

= Notes 27.4 =

Metric:
best_sensor = C

- Starting to refactor and finalize signal based pm.
- Explore smaller dataset using App and then deploy for larger dataset
  using script.
- Taking All features vs PCA vs selected from ANOVA example.
- Using All features 
- Statical features can be efficient calculated.
- Calculation Welch Power Spectum take some time too. Not in uC.

- PCA transform data to lower dimension, some useful information can be
  lost.
- It's look like ANOVA has better performance 

* [X] Anova vs PCA:
    * [X] It's clear that ANOVA performance is much much better reduce
          number of features.


= Encoder =
On encoder data using all (48) features, 100 % can be achieved. Data has a
lot of information about the process.

Using PCA Accuracy 97 % (Fine KNN) using 6 pca-components for classification.

But we need to calculate this 48 features to take 6 components. This is not
good :)

We can pre-rank features using ANOVA and take only 5-10 best features:
Only 5 best features gives 99.2% best result. But using same Fine KNN 96.7%
accuracy. A lot of classifiers has more than 90% accuracy. If we will
deploy algorithms in uC or less efficient PC it's better to use minimal
number of features (Better only statistic).
It's not nescessary to use a PCA, but can be used. 
1-PCA component 90+% accuracy achieved. Fine KNN 95 %

== Small Dataset ==

| All features | All+PCA   | ANOVA     | ANOVA+PCA | Statis     | Statis+PCA  |
|--------------|-----------|-----------|-----------|------------|-------------|
| 99.8%        | 97%(6pca) | 99.2%(5f) | 95%(1pca) | 99.7%(10f) | 92.3%(2pca) |

Best features:
[[file:txt_features/enc_features.txt]]

== Full dataset ==
* [X] LP_stats
* [X] LV_stats
* [X] LP_ps
* [ ] LV_ps

Lever position static data
| ANOVA | Model    |
|-------|----------|
| 99.7% | Fine KNN |

Velocity stats data:


== Conclusion ==
Very good accuracy, 2 useful signals: displacement and velocity. Only
static can be used. But very expensive sensor.


= Proximity sensors =
Proximity sensors are digital sensors with 1/0 signal. There is no
frequency domain. Only statistical features.
Using correlation importance every feature goes to 0 or NaN.

Maybe binary health vs fault will work.
TODO:

* [ ] In combined faulses it will 100% fail?


| All features  | All+PCA   | ANOVA     | ANOVA+PCA   |
|---------------|-----------|-----------|-------------|
| 99.2%         | 82%(2pca) | 90.3%(8f) | 85.9%(1pca) |
| 94.7% (Ftree) |           |           |             |


== Conclusion ==

Need to be proved on bigger dataset. But it's very cheap. If it will work
it will be very good results.

Maybe in combination with another sensor will be good.


= Flow sensor =
Flow sensors. This two sensors are in one side (chamber A input and
output).

2 sensors together:
- 65 features

ANOVA:
- 8 features

WOW, Flow Contraction sensor has very good performance.
 
| All features | All+PCA     | ANOVA   | ANOVA+PCA | Extr (ANOVA) | Contr (ANOVA) |
|--------------|-------------|---------|-----------|--------------|---------------|
| 99.8%        | 99.8%(8pca) | 98%(8f) | 92%(3pca) | 90%(6f)      | 99.4%(6f)     |


Best features:
[[file:txt_features/flow_features.txt]]

== Full data ==
* [X] FC_stats
* [X] FE_stats
* [X] FC_ps
* [X] FE_ps

band 0-55, 5 peaks
* [X] FC_ps_spec
* [X] FE_ps_spec

=== FlowContraction ===
FC only - 97% model work

== Conclusion ==
Very good performance of Flow Contraction Sensor. If that will be true on
bigger dataset -  shock content :)
Not cheap, but good performance.

Big dataset works well

= Pressure =
Pressure sensor always will be because of pressure control.

Air Pressure - divided to preprocessed and raw:

Air Pressure RAW performance:
11 features only static

| 11 static features |
|--------------------|
| 82%                |


Air Pressure preprocessed performance:
| 24 static features | with PCA |
|--------------------|----------|
| 78%                | 50%      |

== Full dataset ==
0-15HZ band; 10 peaks

* [ ] Full features

== Conclusion ==
Very bad :) 

= Acc =

All features = 116 features
| All features | All+PCA    | ANOVA   | ANOVA+PCA |
|--------------|------------|---------|-----------|
| 99.5%        | 77%(21pca) | 97%(8f) | 73%(1pca) |

Moving acc:
First 10 features by ANOVA:
| 10 features |
|-------------|
| 97%         |

Static acc:
First 10 features by ANOVA:
| 10 features |
|-------------|
| 95.6%       |

== Full dataset ==
* [X] All statistics
* [X] All ps

10 peaks, band 0-301
* [X] All ps_spec

== Conclusion ==
In test dataset good performance.

= Mic =
3 mics - > 6 combinations
3 microphones:
- upper
- bottom
- ambient

All 3 together:
92 features
| All features | All+PCA    | ANOVA     |
|--------------|------------|-----------|
| 99.7%        | 88%(10pca) | 97.9%(8f) |

Only upper first 10 ANOVA:
| 10 features |
|-------------|
| 99.2%       |


Only bottom first 10 ANOVA:
| 10 features |
|-------------|
| 98.3%       |

Only ambient first 10 ANOVA:
| 10 features |
|-------------|
| 98.3%       |

== Full dataset ==
Calculation:
* [X] uMic_ps
* [X] bMic_ps
* [X] ambMic_ps

band 0-1e4, 10 peaks
* [X] uMic_ps_spec
* [X] bMic_ps_spec
* [X] ambMic_ps_spec

* [X] uMic_stats
* [X] bMic_stats
* [X] ambMic_stats

= Strain Gauge =
Without preprocessing
All features: 33 features:

| All features | All+PCA    | ANOVA     |
|--------------|------------|-----------|
| 98.6%        | 87.9(1pca) | 98.5%(5f) |

== Full dataset ==
band: 0-40 HZ, 10 peaks
* [X] All features

== Conclusion ==
Very good results on test data. 
