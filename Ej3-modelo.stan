data {
  int<lower=0> N;         // Número de observaciones
  vector[N] x;            // Variable explicativa (Calificaciones de Moody's)
  vector[N] y;            // Variable respuesta (Calificaciones de S&P)
}

parameters {
  real alpha;             // Intersección
  real beta;              // Pendiente
  real<lower=0> sigma;    // Desviación estándar del término de error
}

model {
  // Prioris no informativos para los parámetros alpha y beta
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
  
  // Prior no informativo para sigma usando Gamma
  sigma ~ gamma(1, 0.01);

  // Modelo de regresión
  y ~ normal(alpha + beta * x, sigma);
}
