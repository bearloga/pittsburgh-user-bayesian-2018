data {
  int<lower=0> N;
  int y[N];
  real T[2];
}

parameters {
  real<lower=0> lambda[3];
}

model {
  lambda ~ normal(300, 100);
  for (i in 1:N) {
    if (i > T[1]) {
      if (i <= T[2]) {
        y[i] ~ poisson(lambda[2]);
      } else {
        y[i] ~ poisson(lambda[3]);
      }
    } else {
      y[i] ~ poisson(lambda[1]);
    }
  }
}
