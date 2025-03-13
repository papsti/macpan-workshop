# Plot the SI Model
(si
  ## Use the specification to create a simulator object, which knows how many 
  ## time steps to run and what variables to simulate.
  |> mp_simulator(time_steps = 50, outputs = "incidence")
  
  ## Simulate trajectories from the model.
  |> mp_trajectory()
  
  ## Rename the generic 'value' column to be more informative.
  |> rename(incidence = value)
  
  ## Line plot of the incidence trajectory.
  |> ggplot()
  + geom_line(aes(time, incidence))
  + theme_bw()
)

# Plot SHIVER Model
(shiver
  ## Use the specification to create a simulator object, 
  ## which knows how many time steps to run and what 
  ## variables to simulate.
  |> mp_simulator(time_steps = 500, outputs = mp_state_vars(shiver))
  ## Simulate trajectories from the model.
  |> mp_trajectory()
  
  ## Apply the sorting of states to the resulting trajectories.
  |> mutate(state = matrix)
  
  ## Plot the trajectories.
  |> ggplot()
  + geom_line(aes(time, value))
  + facet_wrap(~ state, scales = "free", ncol = 2)
  + theme_bw()
)
