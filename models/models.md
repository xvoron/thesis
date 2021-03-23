%title Models
%date
:models:
----
= Contents =
    - [[#Notes|Notes]]
        - [[#Notes#Scans|Scans]]
    - [[#Models|Models]]
    - [[#News|News]]
    - [[#Latex|Latex]]
    - [[#Sources|Sources]]
    - [[#Code|Code]]

= Notes =
- [[file:../doc/doc_model/scans/equations.pdf|equations]] 
- [[file:doc/scans/models.pdf|models]] 
- [[file:doc/scans/notes.pdf|notes]] 

== Scans ==
- [[file:doc/scans/hard_stop.pdf|Hard stop]]
- [[file:doc/scans/spool_valve.pdf|Spool Valve]]
- [[file:doc/scans/simply_cylinder_math_model.pdf|Simply cylinder model]]
 
= Models = 
[[../doc/notes/sensors]]
[[../doc/notes/pneustand_components]]


=== Encoder ===
Linear encoder:
{{{matlab
function [cPos] = Conversion_Enc(RawData)
% This function converts the electrical signal to physical quantity for the
%% Linear Encoder: RLS LA11 SQ C 08B B A 10D F 00

%% Parameters
counterBits = 32;
resolution = 7.8125e-6;

%% Conversion
% Convert data unsigned to signed 
signedThreshold = 2^(counterBits - 1);
RawData(RawData>signedThreshold) = -(RawData(RawData > signedThreshold) - 2^counterBits);

% Convert tick -> cm
cPos = RawData * resolution;

end
}}}

= News =
- [[file:../meetings/scans/meeting_10_9_2020.pdf|whiteboard]]

= Latex =
- [[file:../doc/latex/models/models.tex|tex]]
- [[file:../doc/latex/models/models.pdf|pdf]]
 
= Code =
- [[file:matlab/params.m|params]]
- [[file:matlab/config.m|config]]


= TODO =

* [ ] Sensors:
    * [ ] Flow
    * [ ] Acceleration
    * [ ] Pressure
    * [ ] Proximity
    * [ ] Strain-gauge
    * [ ] Mic
    * [ ] Position
    * [ ] ...
* [ ] Parameters finalize
* [ ] 



