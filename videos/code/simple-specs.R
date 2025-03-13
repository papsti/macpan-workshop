library(macpan2); library(tidyverse)
si = mp_tmb_model_spec(
    during = mp_per_capita_flow("S", "I", "beta * I / N", "incidence")
  , default = list(beta = 0.25, S = 99, I = 1, N = 100)
)
sir = mp_tmb_model_spec(
    during = list(
        mp_per_capita_flow("S", "I", "beta * I / N", "infection")
      , mp_per_capita_flow("I", "R", "gamma", "recovery")
    )
  , default = list(
        beta = 0.2, gamma = 0.1
      , S = 99, I = 1, R = 0, N = 100
    )
)
shiver = mp_tmb_model_spec(
    during = list(
        N_mix ~ N - H
      , mp_per_capita_flow("S", "V", "((a * S)/(b + S))/S", "vaccination")
      , mp_per_capita_flow("V", "S", "rho"                , "vaccine_waning")
      , mp_per_capita_flow("S", "E", "I * beta_s/N_mix"   , "unvaccinated_infection")
      , mp_per_capita_flow("V", "E", "I * beta_v/N_mix"   , "vaccinated_infection")
      , mp_per_capita_flow("E", "I", "alpha"              , "progression")
      , mp_per_capita_flow("I", "R", "gamma_i"            , "infectious_recovery")
      , mp_per_capita_flow("I", "H", "sigma"              , "hospitalizations")
      , mp_per_capita_flow("H", "R", "gamma_h"            , "hospital_recovery")
    )
  , default = list(
        a = 10, b = 10
      , rho = 0.05
      , beta_s = 0.2, beta_v = 0.05
      , alpha = 1/2
      , gamma_i = 0.1, gamma_h = 0.07
      , sigma = 0.05
      , N = 10000, S = 9999, I = 1, V = 0, E = 0, H = 0, R = 0
    )
)
