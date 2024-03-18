data {
  int solicitados; // Cantidad de créditos solicitados
  int otorgados;   // Cantidad de créditos otorgados
  real alpha_prior;  // Parámetro alpha de la distribución beta inicial
  real beta_prior;   // Parámetro beta de la distribución beta inicial
}

parameters {
  real<lower=0, upper=1> theta; // Parámetro theta a estimar (proporción de créditos otorgados)
}

model {
  // Prior: Distribución beta inicial con parámetros alpha y beta calculados previamente
  theta ~ beta(alpha_prior, beta_prior);
  
  // Verosimilitud: Distribución binomial de los datos del año 2024
  otorgados ~ binomial(solicitados, theta);
}
