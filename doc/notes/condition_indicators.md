%title Inedtify condition indicators

= Basics = 
*Condition indicators* are features whose behavior changes in predictable
way as the system degrades or operates in different operation modes.

Any feature that predict health operation or Fault state and might be
useful for RUL.


= Signal-Based =
A signal-based condition indicators generates from processing signal data.
All signal processing techniques can be useful *[[signal_process]]*.

= Model-Based =
Condition indicator is a quantity derived from fitting system data to
a model and performing further processing using the model.

Using when:
- difficult to identify signal-based CI.
- measured signals depending on input signal
- understand system dynamic process
- there is a system parameter that will change as the system degrades
- want to do forecasting or simulation of the future (RUL)

In some cases it's useful to use data extracted from model (static or
dynamic model). CI from model are:
- Model parameters
- Statical properties of model parameters (variance)
- Dynamical properties (state values by state estimator)


== Static models ==
???
Pump example

== Dynamic models ==
Systems depending on internal state.

Functions for dynamic model fitting:
- *ssest*: State space estimator model from time-domain or freq-domain data
- *ar*: Least-squared autorecursive (AR) model from time-series data
- *nlarx*: Nonlinear model using nonlinearity estimators (wavelet net,
  tree, sigmoid net)
- *recursiveARX*: Real time fit model

=== CI based on model params ===
Any parameter of a model might be a useful condition indicator.
- poles location
- damping coefficient

We can use functions as:
- damp
- pole
- zero

Another approach is *modalfit*. Modal analysis?

* Differential equations
* gray-box:
    - *pem*
    - *nlarx*
* Simulink model (simulink design optimization)

=== CI based on Residuals ===
Simulate model output and compare results from model with real data.
Difference between 2 signals is called residual signal.

For creating models:
- *nlarx*
- *ar*
- *ssest*

For simulation:
- *sim*
- *resid*

=== State estimators ===
Unexpected changes in state values can therefore indicate fault conditions.
- *unscentedKalmanFilter*
- *extendedKalmanFilter*
- *particleFilter*
