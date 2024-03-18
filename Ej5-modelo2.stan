data {
  int<lower=0> N; // Número de observaciones
  int y[N]; // Conteo de desastres por año
  real x[N]; // Año de cada observación
}

parameters {
  real alpha; // Intercepto
  real beta; // Pendiente
}

model {
  // Priors
  alpha ~ normal(0, sqrt(1000)); 
  beta ~ normal(0, sqrt(1000)); 

  // Modelo de Poisson para el log del parámetro de tasa
  for (n in 1:N) {
    y[n] ~ poisson_log(alpha + beta * x[n]);
  }
}

generated quantities {
  int y_pred[N]; // Predicciones de la cantidad de desastres
  for (n in 1:N) {
    y_pred[n] = poisson_log_rng(alpha + beta * x[n]);
  }
}


