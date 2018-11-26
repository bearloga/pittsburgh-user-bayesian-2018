data {
  int<lower=0> N;
  int y[N];
  real x1[N];
  real x2[N];
  real x3[N];
}

parameters {
  real beta[3];
}

transformed parameters {
  real lp[N];
  real mu[N];
  for (i in 1:N) {
    lp[i] = beta[1] * x1[i] + beta[2] * x2[i] + beta[3] * x3[i];
    mu[i] = exp(lp[i]);
  }
}

model {
  for (i in 1:N) {
    y[i] ~ poisson(mu[i]);
  }
}

generated quantities {
  real lambda[3];
  real diff21;
  real diff32;
  real diff31;
  lambda[1] = exp(beta[1]);
  lambda[2] = exp(beta[1] + beta[2]);
  lambda[3] = exp(beta[1] + beta[3]);
  diff21 = lambda[2] - lambda[1];
  diff32 = lambda[3] - lambda[2];
  diff31= lambda[3] - lambda[1];
}
