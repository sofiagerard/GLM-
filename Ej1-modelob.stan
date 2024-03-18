data {
  int solicitados; // Cantidad de créditos solicitados
  int otorgados;   // Cantidad de créditos otorgados
  real mu_prior;  // Parámetro mu de la distribución normal inicial
  real sigma_prior;   // Parámetro sigma de la distribución normal inicial
}

parameters {
  real<lower=0, upper=1> theta; // Parámetro theta a estimar (proporción de créditos otorgados)
}

model {
  // Prior: Distribución normal inicial con parámetros mu y sigma calculados previamente
  theta ~ normal(mu_prior, sigma_prior);
  
  // Verosimilitud: Distribución binomial de los datos del año 2024
  otorgados ~ binomial(solicitados, theta);
}
