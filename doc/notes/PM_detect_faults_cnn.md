%title Predictive Maintenance: detect Faults from Sensors with CNN

= Contents =
    - [[#Intro|Intro]]
    - [[#Dataset|Dataset]]
        - [[#Dataset#Importing data|Importing data]]
    - [[#Model|Model]]
    - [[#Result visualization|Result visualization]]
    - [[#Dimension reduces|Dimension reduces]]

= Intro =
Predictive Maintenance is becoming more popular in Machine Learning field
during last years. This problem very challenging and require good knowledge
of the domain or to understand basics of fundamental system working.

= Dataset =
Data from different sensors are accumulated to one dataset.
1. Preprocess dataset
2. Annotate failures

Purpose is to predict condition on annotated dataset.
E.g. If a particular component is close to fail for every cycle.

== Importing data ==
{{{python
import pandas as pd
import os
path = os.getpath()
label = pd.read_csv(path+"file", sep=' ', header=None)
label.colomns = [' ', ' ', ' ']
data = ['data1.txt', 'data2.txt', 'data3.txt']
df = pd.DataFrame()

for txt in data:
    read_df = pd.read_csv(path+txt, sep='\t', header=None)
    df = df.append(read_df)
    
}}}

= Model =
There are a lot of types of the models can be used.
* Confusion matrix

= Result visualization =
Decoder can be used:
{{{python
emb_model = Model(inputs=model_m.input, outputs=model_m.get_layer('G_A_P_1D').output)
}}}

= Dimension reduces =
* PCA
* T-SNE
