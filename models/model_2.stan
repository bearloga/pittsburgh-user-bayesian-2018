data {
  int<lower=0> N;
  int y[N];
  int<lower=1> T[2];
  int<lower=0> d[2];
}

parameters {
  real slope[2];
  real<lower=0> lambda[3];
}

model {
  real j;
  lambda ~ normal(300, 100);
  for (i in 1:N) {
    if (i > T[1]) {
      if (i <= T[2]) {
        if (i <= T[1] + d[1]) {
          j = i - T[1];
          y[i] ~ poisson(lambda[1] + slope[1] * j);
        } else {
          y[i] ~ poisson(lambda[2]);
        }
      } else {
        if (i <= T[2] + d[2]) {
          j = i - T[2] - 1;
          y[i] ~ poisson(lambda[2] + slope[2] * j);
        } else {
          y[i] ~ poisson(lambda[3]);
        }
      }
    } else {
      y[i] ~ poisson(lambda[1]);
    }
  }
}

generated quantities {
  real diff21 = lambda[2] - lambda[1];
  real diff32 = lambda[3] - lambda[2];
  real diff31 = lambda[3] - lambda[1];
}
