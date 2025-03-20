library(macpan2); library(tidyverse)

### exercises from
### https://canmod.github.io/macpan-workshop/exploration-exercises.html#calibrate-to-simulation-data

### exercise 1: calibrate

# get some data to calibrate to and look at it
data <- readr::read_csv("https://raw.githubusercontent.com/canmod/macpan-workshop/refs/heads/main/data/simulated-sir.csv")

ggplot2::ggplot(
  data,
  mapping = ggplot2::aes(x = time, y = value)
) +
  ggplot2::geom_point()

# grab the SIR model
model <- mp_tmb_library("starter_models", "sir", package = "macpan2")

# set up the calibrator
cal <- mp_tmb_calibrator(
    spec = model
    , data = data
    , traj = "I" # model variable matching the data
    , par = c("beta", "gamma") # parameters we're optimizing over
    , outputs = "I" # return prevalence
  ) 

# calibrate (this will update cal!)
mp_optimize(cal)

(cal
  # show the optimized trajectory and plot against the data
  |> mp_trajectory()
  |> ggplot(aes(time, value)) 
  + geom_line()
  + geom_point(
    data = data
  , colour = "blue"
  )
)

# nice fit!

### exercise 2: offset calibration

data_start <- 25
data_subset <- data[data$time > data_start, ]

# set up the calibrator
cal <- mp_tmb_calibrator(
  spec = model
  , data = data_subset
  , traj = "I" # model variable matching the data
  , par = c("beta", "gamma") # parameters we're optimizing over
  , outputs = "I" # return prevalence
  , time = mp_sim_offset(data_start, 0, "steps")
) 

# calibrate (this will update cal!)
mp_optimize(cal)

(cal
  # show the optimized trajectory and plot against the data
  |> mp_trajectory()
  |> ggplot(aes(time, value)) 
  + geom_line()
  + geom_point(
    data = data_subset
    , colour = "blue"
  )
)
