library(macpan2)

# using equations as defined here: https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SEIR_model

# define the model
seir <- mp_tmb_model_spec(
  before = list(
    N ~ S + E + I + R # calculate population size before the simulation loop begins to avoid having to specify a value for it by hand in the defaults list
  ),
  during = list(
    # births
    mp_per_capita_inflow(
      from = "N", to = "S",
      rate = "mu", 
      abs_rate = "births" # label for absolute flow
    ),
    # deaths
    mp_per_capita_outflow(
      from = "S",
      rate = "mu",
      abs_rate = "deaths_S"
    ),
    mp_per_capita_outflow(
      from = "E",
      rate = "mu",
      abs_rate = "deaths_E"
    ),
    mp_per_capita_outflow(
      from = "I",
      rate = "mu",
      abs_rate = "deaths_I"
    ),
    mp_per_capita_outflow(
      from = "R",
      rate = "mu",
      abs_rate = "deaths_R"
    ),
    # infection
    mp_per_capita_flow(
      from = "S", to = "E",
      rate = "beta*I/N",
      abs_rate = "infections"
    ),
    # infectiousness onset
    mp_per_capita_flow(
      from = "E", to = "I",
      rate = "a",
      abs_rate = "infectious"
    ),
    # recovery
    mp_per_capita_flow(
      from = "I", to = "R",
      rate = "gamma",
      abs_rate = "recoveries"
    )
  ),
  default = list(
    mu = 0.1, # 0.01 avg births (and deaths) per individual per day
    beta = 0.5, # 0.1 avg new infections per infectious per susceptible per day 
    a = 1/3, # 3 days avg latent period
    gamma = 1/5, # 5 days avg infectious period 
    S = 9999,
    E = 0, 
    I = 1,
    R = 0
  )
)

# view model specification object
print(seir)

# create simulator
seir_simulator <- mp_simulator(
  model = seir,
  time_steps = 365
  , outputs = mp_state_vars(seir)
)

# generate trajectory
sim <- mp_trajectory(seir_simulator) |> 
  dplyr::mutate(matrix = forcats::as_factor(matrix)) # natural order of state variables

# visualize trajectory

# variable labeller
matrix_labeller <-  c(
    "S" = "Susceptible",
    "E" = "Exposed",
    "I" = "Infectious",
    "R" = "Recovered"
  )

ggplot2::ggplot(
  data = sim,
  mapping = ggplot2::aes(x = time, y = value, colour = matrix)
) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(
    ~ matrix, 
    labeller = ggplot2::labeller(matrix = matrix_labeller),
    scales = "free_y") + 
  ggplot2::labs(
    title = "Simulation of the SEIR model with balanced births and natural deaths",
    subtitle = "For this set of parameters, we observe convergence to the endemic equilibrium",
    x = "Days from beginning of outbreak",
    y = "Number of individuals"
  ) + 
  ggplot2::guides(
    colour = "none"
  )

# convergence to endemic equilibrium!
