%title Some general sentenses

= Intro =
The monitoring of manufacturing equipment is vital to any industrial process.
Sometimes it is critical that equipment be monitored in real-time for faults and anomalies
to prevent damage and correlate equipment behavior faults to production line issues.
Fault detection is the pre-cursor to predictive maintenance.

There are several methods which don't require training of a neural network to be able
to detect failures, starting with the most basic (FFT),
to the most complex (Gaussian Mixture Model).
These have the advantage of being able to be re-used with minor modifications on different
data streams, and don't require a lot of known previously classified data (unlike neural nets).
In fact, some of these methods can be used to classify data in order to train DNNs.


== Basic Terminology ==
- Faults: A fault is an unpermitted deviation of at least one
          characteristics property (feature) of the system from the
          acceptable, usual, standard condition.
- Failure: A failure is a permanent interruption of a system’s
           ability to perform a require function under specified
           operating conditions.
- Malfunction: A malfunction is an intermittent irregularity in the
               fulfillment of a system’s desired function.

= Methods =
1. Data and signal
2. Model based
3. Knowledge Based

= Maintenance =
- Reactive maintenance
- Preventive maintenance
- Predictive maintenance


