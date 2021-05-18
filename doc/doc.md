%title Documentation

- [[notes/fdipm]]: Notes about FDI and PM
- [[sensors/sensors]]: Sensors information

= NEW INFORMATION =

- [[https://gregstanleyandassociates.com/whitepapers/FaultDiagnosis/faultdiagnosis.htm]]
- Signal based: easy extract and train model
- Model based: Residual same as:
[[https://www.mathworks.com/help/predmaint/ug/fault-diagnosis-of-centrifugal-pumps-using-residual-analysis.html]]
- Using model:
    - Generate data for RUL
    - Apply RUL:
    - https://www.mathworks.com/help/predmaint/ug/wind-turbine-high-speed-bearing-prognosis.html

Very good article about fdi
https://www.intechopen.com/books/fault-diagnosis-and-detection/fault-detection-and-isolation

Acc Vibration modeling:
https://www.mathworks.com/help/predmaint/ug/Use-Simulink-to-Generate-Fault-Data.html

= FDI =

Automated fault detection and diagnosis depends heavily on input from
sensors or derived measures of performance.  In many applications, such as
those in the process industries, sensor failures are among the most common
equipment failures.

 When models of the observed system are used as a basis for fault detection
 and diagnosis, this is often referred to as "model based reasoning"
 
 
There are many advantages to using models, such as:

- Models can be used for prediction of the impacts of faults as well as
  diagnosis -- the model is independent of the application.
- Application development is formalized; often easier to review and re-use
  with fewer errors for multiple instances of the same equipment
- Assumptions and limitations are likely to be clearer
- Especially for first principles models, they are likely to reflect
  physical laws rather than observed coincidences that might only be true
  under certain conditions.

There are many variations on model based reasoning.  The models might
represent normal operations or abnormal operations.  They might be
quantitative (based on numbers and equations) or qualitative (for instance,
based on cause/effect models), causal or non-causal, “compiled” vs. “first
principles”, probabilistic vs. deterministic, and so on.   These variations
are outlined next.


== Models of abnormal vs. normal operation ==

For systems characterized by numerical variables, engineering models such
as algebraic equations or differential equations can be used as models of
normal operation.   Neural nets, when trained as function approximators,
can also be used as models of normal operation.  Other forms of models
defining normal operation include state transition diagrams.  Fault
detection then involves checking that these models are being followed in
the observed sensor data.  For instance, the equations in a mathematical
model should be satisfied within some tolerance, or certain sequences
should be followed when the model is a state transition diagram.  

Problem starts if normal operation model, start working in different model
conditions, in this conditions, the models became less accurate -> so
residuals indicate "false positive" problem. (Problem does not but problem
registered).

Some applications require only fault detection.
However, in most application fault isolation required (pinpoint the root
causes of problems).

Normal behavior models are complex and costly to develop and maintain.
Alternative is abnormal behavior models.


Hybrid approach is to use residuals from model of normal operation as
inputs to abnormal operation models (some loss of flow is input to
fault-flow model). This approach uses Kalman filters and NN. Residuals
between estimated values and measured are inputs to pattern matching?


== Quantitative vs Qualitative Models ==
- Quantitative: algebraic, differential, difference equations
- Qualitative: state transition diagram ?

== Compile vs First Principles ==
- Compile: data-driven
- First Principles: engineering

== source == 
- [[https://gregstanleyandassociates.com/whitepapers/FaultDiagnosis/Model-Based-Reasoning/model-based-reasoning.htm]]

