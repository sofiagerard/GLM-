data {
  int<lower=0> N;                 // Número de observaciones
  vector[N] utilidades;           // Utilidades mensuales
}

parameters {
  real mu;                        // Media de la distribución normal
  real<lower=0> sigma_sq;         // Varianza de la distribución normal
}

model {
  // Distribuciones iniciales no informativas/debilmente informativas
  mu ~ normal(0, 10000);            // Media con distribución normal amplia
  sigma_sq ~ inv_gamma(0.001, 0.001);  // Varianza con distribución Inversa-Gamma muy amplia
  
  // Verosimilitud (likelihood)
  utilidades ~ normal(mu, sqrt(sigma_sq));  // Usar la raíz cuadrada de sigma_sq para la desviación estándar
}
