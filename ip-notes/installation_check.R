library(macpan2); library(tidyverse)

("starter_models"
  |> mp_tmb_library("sir", package = "macpan2")
  |> mp_simulator(time_steps = 50, outputs = "infection")
  |> mp_trajectory()
  |> mutate(incidence = value)
  |> ggplot() 
  + geom_line(aes(time, incidence))
  + theme_bw()
)
