data {
  int<lower=0> N;             // number of observations
  int<lower=0> disasters[N];  // disaster counts
  real years[N];              // year for each observation
  real min_year;              // the minimum year in the dataset
  real max_year;              // the maximum year in the dataset
}

parameters {
  real beta0;                 // intercept
  real beta1;                 // change in rate after switchpoint
  real<lower=min_year, upper=max_year> tau; // switchpoint year, as a real
}

model {
  // Priors
  beta0 ~ normal(0, sqrt(1000)); // precision 
  beta1 ~ normal(0, sqrt(1000)); // precision 
  tau ~ uniform(min_year, max_year);
  
  // Likelihood
  for (i in 1:N) {
    real mu = exp(beta0 + beta1 * (years[i] >= tau));
    disasters[i] ~ poisson(mu);
  }
}
