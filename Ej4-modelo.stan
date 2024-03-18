data {
  int<lower=0> N;             // Número de observaciones existentes
  vector[N] X1;               // Índice de calidad de trabajo para las observaciones existentes
  vector[N] X2;               // Número de años de experiencia para las observaciones existentes
  vector[N] X3;               // Índice de éxito en publicaciones para las observaciones existentes
  vector[N] Y;                // Salario para las observaciones existentes
  int<lower=0> N_new;         // Número de nuevas observaciones (nuevos empleados)
  vector[N_new] X1_new;       // Índice de calidad de trabajo para los nuevos empleados
  vector[N_new] X2_new;       // Número de años de experiencia para los nuevos empleados
  vector[N_new] X3_new;       // Índice de éxito en publicaciones para los nuevos empleados
}
parameters {
  real alpha;                 // Intercepto
  real beta1;                 // Coeficiente para X1
  real beta2;                 // Coeficiente para X2
  real beta3;                 // Coeficiente para X3
  real<lower=0> sigma;        // Desviación estándar del error
}
model {
  // Priors
  alpha ~ normal(0, 10);
  beta1 ~ normal(0, 10);
  beta2 ~ normal(0, 10);
  beta3 ~ normal(0, 10);
  sigma ~ cauchy(0, 2.5);
  
  // Likelihood
  Y ~ normal(alpha + beta1 * X1 + beta2 * X2 + beta3 * X3, sigma);
}
generated quantities {
  vector[N_new] salary_pred;
  for (i in 1:N_new) {
    // Simular una predicción de salario con incertidumbre
    salary_pred[i] = normal_rng(alpha + beta1 * X1_new[i] + beta2 * X2_new[i] + beta3 * X3_new[i], sigma);
  }
}

// vector `salary_pred` que contiene las predicciones del salario para cada uno
// de los cinco nuevos empleados basadas en los coeficientes de regresión estimados
// y las variables explicativas para cada nuevo empleado.
