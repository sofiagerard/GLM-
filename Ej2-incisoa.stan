data {
  int N;                           // Número de observaciones
  vector[N] utilidades;            // Utilidades mensuales
  real prior_mu_mean;              // Media de la distribución previa para mu
  real prior_mu_var;               // Varianza de la distribución previa para mu
  real prior_sigma_shape;          // Parámetro de forma de la distribución previa para sigma^2
  real prior_sigma_rate;           // Parámetro de tasa de la distribución previa para sigma^2
}

parameters {
  real mu;                         // Media de la distribución normal
  real<lower=0> sigma_sq;          // Varianza de la distribución normal (cuadrado de la desviación estándar)
}

model {
  // Prior para mu
  mu ~ normal(prior_mu_mean, sqrt(prior_mu_var)); // Ojo usa sigma no var

  // Prior para sigma^2
  sigma_sq ~ gamma(prior_sigma_shape, prior_sigma_rate);

  // Verosimilitud (likelihood)
  utilidades ~ normal(mu, sqrt(sigma_sq)); 
}
