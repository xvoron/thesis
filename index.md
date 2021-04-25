%title MT
%date
:master:pm:fdi:
----
= Contents =
    - [[#Info|Info]]
    - [[#Sections|Sections]]
    - [[#doc|doc]]
    - [[#Meetings|Meetings]]
    - [[#Notes|Notes]]

= New =
- [[https://gregstanleyandassociates.com/whitepapers/FaultDiagnosis/faultdiagnosis.htm]]

- Signal based: easy extract and train model
- Model based: Residual same as:
[[https://www.mathworks.com/help/predmaint/ug/fault-diagnosis-of-centrifugal-pumps-using-residual-analysis.html]]
- Using model:
    - Generate data for RUL
    - Apply RUL:
    - https://www.mathworks.com/help/predmaint/ug/wind-turbine-high-speed-bearing-prognosis.html

Acc Vibration modeling:
https://www.mathworks.com/help/predmaint/ug/Use-Simulink-to-Generate-Fault-Data.html

* [ ] Sort vs PCA ???
    * [ ] PCA takes features and reduce them to Classifier
    * [ ] Sort explain variance between different features
    * [ ] linearization model?


= Info =
- [[wiki0:VUT/RD6|Seminar]]
 
= Sections =
- [[models/models|models]]: Models of pneumatic actuator
- [[sb/sb|signal based pm]]: Signal based Predictive Maintenance
- [[mb/mb|model based pm]]: Model based Predictive Maintenance
- [[doc/doc|doc]]: Documentation
- [[rul/rul|rul]]: Remaining Useful Life approach

= doc =
- [[file:doc/latex/mt.tex|main doc (tex)]]
- [[file:doc/latex/mt.pdf|main doc (pdf)]]

= Meetings =
- [[doc/meetings/20_8_2020]]
- [[doc/meetings/10_9_2020]]
- [[doc/meetings/25_02_2021]]
- [[doc/meetings/14_04_2021]]


----

= Notes =

TODO:
* [ ] [[doc/notes/digital_twin]]

* [.] finish models:
    * [ ] refactor
    * [X] refactor models
* [ ] nn model demo
        * [ ] require more data with different input for proper dynamic
              optimization
        * [ ] Work on synthetic data ?

