library(macpan2)
# get funs
invisible(lapply(list.files(here::here("ip-notes", "R"), full.names = TRUE), source))

# define the model

# using model specification from here: https://canmod.github.io/macpan-workshop/video-resources

measles <- mp_tmb_model_spec(
  before = list(
    N ~ S + V + E + I_reg + I_iso + R
  ),
  during = list(
    # force of infection
    force_of_infection ~ beta * I_reg / N, 
    # infections
    mp_per_capita_flow(
      from = "S", to = "E",
      rate = "force_of_infection",
      abs_rate = "infections_S"
    ),
    mp_per_capita_flow(
      from = "V", to = "E",
      rate = "(1 - epsilon)*force_of_infection",
      abs_rate = "infections_V"
    ),
    # effective vaccination
    mp_per_capita_flow(
      from = "V", to = "R",
      rate = "epsilon * force_of_infection",
      abs_rate = "vaccine_protected"
    ),
    # onset of infectiousness 
    mp_per_capita_flow(
      from = "E", to = "I_reg",
      rate = "(1 - theta)*alpha",
      abs_rate = "infectious"
    ),
    mp_per_capita_flow(
      from = "E", to = "I_iso",
      rate = "theta*alpha",
      abs_rate = "isolated"
    ),
    # recovery
    mp_per_capita_flow(
      from = "I_reg", to = "R",
      rate = "gamma",
      abs_rate = "recovered_I_reg"
    ),
    mp_per_capita_flow(
      from = "I_iso", to = "R",
      rate = "gamma",
      abs_rate = "recovered_I_iso"
    )
  ),
  default = list(
    # parameters
    beta = 0.8,
    epsilon = 0.95, # 95% vaccine efficacy
    theta = 0.1, # proportion of infections that are isolated
    alpha = 1/3, # 1/alpha = avg days to onset of infectiousness
    gamma = 1/5, # 1/gamma = avg infectious period in days
    # initial conditions
    # 1e5 total population
    V = 6e4, # 60% vaccine coverage
    S = 4e4-1, # everyone else, minus one regular infected
    I_reg = 1,
    I_iso = 0,
    E = 0,
    R = 0
  )
)

measles_simulator <- mp_simulator(
  measles,
  time_steps = 365,
  outputs = c(mp_state_vars(measles), "force_of_infection")
)

sim <- mp_trajectory(measles_simulator) |> 
  dplyr::mutate(matrix = forcats::as_factor(matrix))

matrix_labeller <- c(
  "S" = "Susceptible",
  "V" = "Vaccinated",
  "E" = "Exposed",
  "I_reg" = "Infectious",
  "I_iso" = "Isolated",
  "R" = "Removed",
  "force_of_infection" = "Force of infection"
  
)

plot_sim(
  sim, 
  matrix_labeller,
  title = "Simulation of a measles model with vaccination and isolation",
  subtitle = "Vaccine coverage and isolation proportion inadequate to prevent an epidemic"  
)
