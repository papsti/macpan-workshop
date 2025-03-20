library(macpan2); library(tidyverse)
sir = mp_tmb_library("starter_models", "sir", package = "macpan2")
data = read_csv("https://raw.githubusercontent.com/canmod/macpan-workshop/refs/heads/main/data/early_covid_on_reports.csv")
cleaned_data = (data
  |> rename(time = date, matrix = var)
  |> select(-province)
)
sir_covid = mp_tmb_insert(sir

    ## Modify the the part of the model that
    ## is executed once "during" each iteration
    ## of the simulation loop.
    , phase = "during"

    ## Insert the new expressions at the 
    ## end of each iteration.
    ## (Inf ~ infinity ~ end)
    , at = Inf

    ## Specify the model for under-reporting as
    ## a simple fraction of the number of new
    ## cases every time-step.
    , expressions = list(report ~ report_prob * infection)

    ## Update defaults to something a little more 
    ## reasonable for early covid in Ontario.
    , default = list(
          gamma = 1/14      ## 2-week recovery
        , beta = 2.5/14     ## R0 = 2.5
        , report_prob = 0.1 ## 10% of cases get reported
        , N = 1.4e7         ## ontario population  
        , I = 50            ## start with undetected infections
    )
)
cal = mp_tmb_calibrator(sir_covid, cleaned_data
  , traj = "report"
  , par = c("beta", "gamma")
)
mp_optimize(cal)
fitted_data = mp_trajectory(cal)
(ggplot()
  + geom_line(aes(time, value), data = fitted_data)
  + geom_point(aes(time, value), data = cleaned_data)
)
