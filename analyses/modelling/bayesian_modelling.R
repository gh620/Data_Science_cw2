library(rstan)

print_posteriors_and_diagnostics <- function(fit) {
  info <- as.data.frame(summary(fit)$summary)
  info <- info[!grepl("_squared|lp__|log_lik|^eta|prediction", rownames(info)), ]
  sprintf(
    "Parameter %s posterior mean was %2.2f with posterior variance %f\n",
    rownames(info), info$mean, (info$sd)^2
  ) %>% cat()
  sprintf(
    "Parameter %s effective sample size was %.0f with R hat %f\n",
    rownames(info), floor(info$n_eff), round(info$Rhat, 5)
  ) %>% cat()
  return(info)
}

{
  "
data {
  int<lower=0> N;               // number of observations
  vector<lower=0, upper=1>[N] gender;
  vector<lower=0, upper=1>[N] asymptomatic;
  vector[N] duration;
  vector<lower=0>[N] age;
  int<lower=0, upper=1> y[N] ;
}

parameters {
  real intercept;
  real beta_gender;
  real beta_asympt;
  real beta_duration;
  real beta_age;
}

model {
  intercept ~ normal(0, 100);
  beta_gender ~ normal(0, 100);
  beta_asympt ~ normal(0, 100);
  beta_duration ~ normal(0, 100);
  beta_age ~ normal(0, 100);

  // Likelihood: logistic distribution
  y ~ bernoulli_logit( intercept + gender * beta_gender + asymptomatic * beta_asympt +
    duration * beta_duration + age * beta_age);
}

generated quantities {
  real log_lik[N];

  for (i in 1:N) {
    log_lik[i] = bernoulli_logit_lpmf( y[i] | intercept +
        gender[i] * beta_gender + asymptomatic[i] * beta_asympt +
        duration[i] * beta_duration + age[i] * beta_age);
  }

}
" -> stan_code
}

stan_data <- as.list(covid)
stan_data$N <- nrow(covid)
names(stan_data)[5] <- "y"

path_output <- "logistic_stan.rds"
if (file.exists(path_output)) {
  stan_fit <- readRDS(path_output)
} else {
  stan_fit <- rstan::stan(
    model_code = stan_code,
    data = stan_data,
    model_name = "Logistic Regression",
    chains = 1,
    warmup = 500,
    iter = 2500,
    refresh = 0
  )
  saveRDS(object = stan_fit, file = path_output)
}

info <- print_posteriors_and_diagnostics(stan_fit)
pars <- grep(pattern = "beta|intercept", names(stan_fit), value = TRUE)
traceplot(stan_fit, pars = pars)