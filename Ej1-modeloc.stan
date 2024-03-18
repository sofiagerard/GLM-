data {
  int solicitados;      // Cantidad de créditos solicitados
  int otorgados;        // Cantidad de créditos otorgados
}

parameters {
  real<lower=0, upper=1> theta; // Parámetro theta a estimar (proporción de créditos otorgados)
}

model {
  // Prior: Distribución uniforme no informativa para theta
  theta ~ uniform(0, 1);
  
  // Verosimilitud: Distribución binomial de los datos del año 2024
  otorgados ~ binomial(solicitados, theta);
}
