## Measles problem answers

pop <- 10000

Rzero <- 12
alpha <- 1/20
gamma <- 1/14

I_init <- 1
E_init <- 1

vaxprop <- 0.90
eff <- 0.9

iso <- 0.2

params <- list(beta = Rzero*gamma
	, alpha = alpha
	, gamma = gamma
	, vaxprop = vaxprop
	, eff = eff
	, theta = iso
	, pop = pop
	, I_init = I_init
	, E_init = E_init
	, V_init = vaxprop*pop
	, R_init = 0
	, Iso_init = 0
)

spec = mp_tmb_model_spec(
    before = list(
        R ~ R_init
    	, N ~ pop
    	, E ~ E_init
    	, I ~ I_init
    	, I_iso ~ Iso_init
    	, V ~ V_init
    	, S ~ N - I - I_iso - R - E - V
    )
  , during = list(
        Lambda ~ beta * I / N
      , mp_per_capita_flow("S",     "E"    , "Lambda"        , "infection")
      , mp_per_capita_flow("E",     "I"    , "alpha"         , "progression")
      , mp_per_capita_flow("I",     "R"    , "gamma"         , "recovery")
      , mp_per_capita_flow("V",     "E"    , "(1-eff)*Lambda", "infection_v")
      , mp_per_capita_flow("V",     "R"    , "eff*Lambda"    , "protection")
      , mp_per_capita_flow("E",     "I_iso", "theta*alpha"   , "isolation")
      , mp_per_capita_flow("I_iso", "R"    , "gamma"         , "recovery_iso")
    )
  , default = params
)

sim = mp_simulator(spec, 500, mp_state_vars(spec))
(sim
  |> mp_trajectory()
  |> ggplot(aes(time, value))
  + geom_line()
  + facet_wrap(~matrix, scales = "free")
)
