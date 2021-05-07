%title RUL developing notes

= Data generation =

- [X] Generate prognostic data from model
- [X] Extract condition indicators

- [ ] Train/Validate dataset (using one full ID for validation)



- Model to use?
    - Depends on generated data

- Possible data:
    - Run-to-failure on similar system
    - Known threshold of some CI
    - Lifetime data for similar systems


Survival model:
- How many system fail after some value

Degradation model:
- We have no failure data, but we know some threshold
- Degradation model with confidence interval

Similarity model:
- degradation profiles (evolution CI for each machine in ensemble) from
  health to faulty state
- prediction estimates the RUL as the median life span of most similar
  components minus the current lifetime value.


Similarity models detailed:
- hashed-feature similarity model `hashSimilarityModel` (for bigger datasets):
    - create hash functions for each member (mean, max, min, power)

- Pairwise similarity model find the components whose degradation paths are
  most correlated to test component:
    - Gives better results than hashed model

- Residual similarity model fits prior data to model such as ARMA model


= Similarity-Based RUL = 




= TODO v2 =
- [X] Add some limits for rand function when generate data
- [X] Generate failure data


