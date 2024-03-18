data {
  int<lower=0> N; // Número de observaciones
  int<lower=0> y[N]; // Número de muertes
  int<lower=0> n[N]; // Número de mineros expuestos
  vector[N] x; // Tiempo de exposición al mineral
  int<lower=0> new_N; // Número de mineros para la predicción
  real new_x; // Tiempo de exposición para la predicción
  int<lower=0> new_n[new_N]; // Número de ensayos por minero para la predicción
}


parameters {
  real alpha; // Intercepto
  real beta; // Pendiente
}

model {
  vector[N] mu;

  // Priors
  alpha ~ normal(0, sqrt(1000));
  beta ~ normal(0, sqrt(1000));

  // Likelihood
  for (i in 1:N) {
    mu[i] = alpha + beta * x[i];
    y[i] ~ binomial_logit(n[i], mu[i]);
  }
}

generated quantities {
  int y_pred[new_N]; // Predicciones de muertes para los nuevos mineros

  for (i in 1:new_N) {
    y_pred[i] = binomial_rng(new_n[i], inv_logit(alpha + beta * new_x));
  }
}



