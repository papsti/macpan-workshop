library(macpan2); library(tidyverse)

## step 1: get a spec from the library and simulate
spec = mp_tmb_library("starter_models", "sir", package = "macpan2")
sim = mp_simulator(spec, 50, "infection")
set.seed(1)
data = (sim
  |> mp_trajectory()
  |> mutate(value = rpois(n(), value))
)

## step 2: decompose beta into a baseline and a multiplier
## to control scenarios about beta during forecasts
spec_beta_decomp = mp_tmb_insert(spec
  , expressions = list(beta ~ beta0 * beta_multiplier)
  , default = list(beta0 = 0.2, beta_multiplier = 1)
)

## step 3: calibrate beta0 and gamma
cal = mp_tmb_calibrator(
    spec_beta_decomp
  , data
  , traj = "infection"
  , par = c("beta0", "gamma")
  , default = list(beta0 = 0.25, gamma = 0.2)
)
mp_optimize(cal)
mp_tmb_coef(cal)

# step 4: create a scenario for beta, where transmission increases by
# a factor of 1.2 at time 60.
beta_change = data.frame(matrix = "beta_multiplier", time = 60, value = 1.2)

# step 5: create a forecaster with this scneario
scen = mp_forecaster(cal, forecast_period_time_steps = 50
  , data = bind_rows(data, beta_change)
  , tv = "beta_multiplier"
  , outputs = "log_infection"
)

# step 6: plot the scenario
(mp_trajectory_sd(scen, conf.int = TRUE)
  |> ggplot()
  + geom_line(aes(time, value))
  + geom_ribbon(aes(time, ymax = conf.high, ymin = conf.low), alpha = 0.2)
  + geom_point(aes(time, value), data = data)
  + theme_bw()
)
