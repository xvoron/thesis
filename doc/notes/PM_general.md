%title Generally about Predictive Maintenance

= Contents =
    - [[#Type of Maintenance|Type of Maintenance]]
    - [[#Models|Models]]
    - [[#Condition indicators|Condition indicators]]
    - [[#ML|ML]]
    - [[#RUL|RUL]]
        - [[#RUL#RUL estimator models|RUL estimator models]]
    - [[#Extracting features & Model training|Extracting features & Model training]]


= Type of Maintenance =
- Reactive maintenance
- Preventive maintenance
- Predictive maintenance

= Models =
1. Create mathematical model
2. Estimate parameters from the data
3. Simulate model with different fault states with different working
   conditions
4. Use combination of both data to develop algorithm


= Condition indicators =
* Time domain
* Frequency domain
* Time-Frequency domain

= ML =
Using CI train models:
1. Detect anomalies
2. Classification model
3. Estimate remaining useful life

= RUL =
Time between current condition and Failure condition.

== RUL estimator models ==
Depend on which data do we have:
* Similarity model
* Survival model (Probability distribution)
* Degradation model (Safety threshold)


- Data reduction techniques


= Extracting features & Model training =
Extracting features and Model training is iterative process, where we try
different CI and models for best prediction.


= Digital Twin =
A Digital Twin is an up-to-date representation of a real asset in
operation.
Classification and RUL algorithms will have different Digital Twins.
Benefits:
- Downtime reduction
- Inventory management
- What-if simulations
- Operational planning

Not only system is self, but it can be:
- Only a component of system
- The whole system
- System of systems

Take model data -> update DT

== Creating a DT ==
- Physics-based modeling
- Data-driven modeling
- Kalman filter


