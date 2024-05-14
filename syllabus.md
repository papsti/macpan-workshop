<!-- omit from toc -->
# Using `macpan2`

This is a (currently draft) syllabus for a workshop on using [`macpan2`](https://canmod.github.io/macpan2) for applied public health modelling.

<!-- omit from toc -->
## Table of Contents
- [Instructor](#instructor)
- [Audience](#audience)
- [Background](#background)
- [Materials](#materials)
- [Objectives](#objectives)
- [Outcomes](#outcomes)
- [Schedule](#schedule)
- [Preparation](#preparation)
- [Footnotes](#footnotes)


## Instructor

Steve Walker  –  swalk@mcmaster.ca  –  https://github.com/stevencarlislewalker


## Audience

We assume that workshop participants are professional epidemiological modellers who use, or want to use, compartmental models to address public health issues. The material is specifically tailored to such modellers at the public health agency of Canada.

Without [preparation](#preparation), participants should be comfortable with the following.
* Basic ideas and terminology about [compartmental models in epidemiology](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology).
* Some experience coding to solve scientific problems.[^Rfamiliarity]


## Background

Applied compartmental modelling is a big topic. The following model refinement cycle describes the aspects of this topic for which `macpan2` is designed.

<img src="modelling-cycle.svg" alt="model refinement cycle diagram" style="width: 28em"/>

We have learned from our experience in applied public health modelling that it is better to complete each loop as quickly as possible, rather than trying to produce the perfect model outright. Keeping the scope of each step as limited as possible, or even skipping steps if they are not a priority, is useful for avoiding [analysis paralysis](https://en.wikipedia.org/wiki/Analysis_paralysis). Every time we get back to the **inference** step we have another chance of providing valuable inputs to the public health debate, and so we want to do this as often as possible.

Each step leads to the next in the following way.
* **Exploration** clarifies if our existing parameter values need refinement.
* **Parameterization** refines a model so that it can be used to make defensible inferences in a specific context.
* **Inference** can raise questions about whether a model should be stratified to make it more realistic.
* **Stratification** creates new model behaviours that may require further exploration.

The final stratification step will increase model complexity, which has both advantages and disadvantages. Therefore, complexity will tend to increase as a modelling project iterates through the cycle. Starting with a simple model will help ensure that the project converges on an appropriate level of complexity. Sometimes it is worth resetting the cycle by starting again with a simpler model.

We stress the importance of data and other factual inputs, including expert opinions, into the modelling process. We are concerned with modelling specific real-world problems, and so none of the steps should be too abstract.

We will use this model refinement cycle to provide context when concepts are introduced in the workshop. The instructor will take a modelling example through one cycle throughout the workshop (TODO: what should this example be?). Participants will be given time to try some of these techniques on [their own models that they have come prepared with](#suggested-preparation).

## Materials

There will not be enough time in the workshop to cover all of `macpan2`, so there will be a companion set of online materials [^milestones] that will cover all of the options available to modellers. In the workshop, we will follow one example through one full iteration of the [model refinement cycle](#background). Variations on each skill that is covered will be described in the companion material.

## Objectives

The overall goal of the workshop is to train epidemiological modellers to use `macpan2` software in their efforts to use compartmental modelling to support public health. Each [session](#schedule) will cover techniques associated with one step in the [model refinement cycle](#background).

<!-- omit from toc -->
### Exploring Model Simulations

Participants will learn how to do the following types of tasks required for exploring model simulations.

- [ ]  Find candidate simulation models in the `macpan2` [library](#library-models) of starter models.
- [ ] Prepare certain [types of data](#types-of-data) so that they can be compared with `macpan2` simulation output, both visually and numerically.[^tidyverse]
- [ ] Make [modifications to models](#model-modification-tools) in the library.
- [ ] Compute [epidemiological summaries](#epidemiological-model-summaries) (e.g., $\mathcal{R}_0$).
- [ ] Cast a model as a particular [dynamical model type](#dynamical-model-types) (e.g. discrete-time recursion, ordinary differential equation).

<!-- omit from toc -->
#### Library Models

The [companion material](#materials) will describe each of the following starter models. Although every emerging pathogen has a unique set of characteristics, there typically exist disease models that can serve as starting points in a crisis situation. The `macpan2` [library of candidate models](https://canmod.github.io/macpan2/articles/example_models) includes a variety of pathogens that cover the range of likely characteristics for emerging threats[^milestones].

* Seasonal respiratory illnesses like influenza, COVID-19, RSV.
* Measles and other childhood infections.
* Ebola and pneumonic plague.
* Sexually transmitted diseases like HIV and MPox.
* Vector-mediated pathogens like dengue, Zika, and bubonic plague.

<!-- omit from toc -->
#### Types of Data

The [companion material](#materials) will describe how to prepare the following types of data for comparisons with model simulations.

* Case, symptom, and outcome reports.
* Hospital admissions and occupancy.
* Seroprevalence.
* Cell phone mobility data.
* Genomic data on the relative abundance of pathogen strains.
* Wastewater pathogen concentrations.
* Social attitude data (e.g., vaccine hesitancy).
* Operational and intervention schedules (e.g., vaccination supply, school closures).

<!-- omit from toc -->
#### Model Modification Tools

The [companion material](#materials) will describe how to make the following modifications, or to quickly find and use instructions for making them.

* Add/remove compartments or flows amongst compartments (e.g., a compartment for pathogen concentration in wastewater).
* Add behavioural responses to outbreaks.
* Filter numbers of cases to account for reporting delays, under-reporting, and weekend effects.
* Add schedules of parameter variation in response to exogeneous factors (e.g. transmission rate in response to vaccine supply, school term schedules).
* Add stochastic exogeneous factors (e.g. importation).

<!-- omit from toc -->
#### Epidemiological Model Summaries

The [companion material](#materials) will describe how to compute the following epidemiological model summaries.

* $\mathcal{R}_0$.
* $\mathcal{R}_t$.
* Intrinsic rate of increase, $r$.
* Moments of the generation interval distribution.

<!-- omit from toc -->
#### Dynamical Model Types

The [companion material](#materials) will describe how to cast an existing model as one of the following types of dynamical models.

* Discrete-time recursion (i.e., Euler ODE solver).
* Runge-Kutta 4 (a more accurate ODE solver).
* Discrete-time recursion with process error (using the [Euler-multinomial distribution](https://kingaa.github.io/manuals/pomp/html/eulermultinom.html)).

<!-- omit from toc -->
### Parameterizing for Specific Goals

Participants will learn how to do the following types of tasks required for parameterizing models for making inferences about a particular population and epidemiological problem.

- [ ] Modify the default values of parameters in a model.
- [ ] Express uncertainty in model parameters (e.g., transmission rate) or in [epidemiological summaries](#epidemiological-model-summaries) (e.g., $\mathcal{R}_0$) with prior distributions.
- [ ] Use [optimization](#optimization) to calibrate parameters so that the discrepancy between observed and simulated data is minimized.
- [ ] Parameterize the [initial values of the state variables](#calibrate-initial-state-variables) (e.g. `S`, `I`) so that they can be optimized.
- [ ] Calibrating the functional form of time-variation of parameters using machine learning components embedded within epidemiological models. This is a useful technique when the reasons for parameter time-variation are not well-understood.

<!-- omit from toc -->
#### Optimization

The [companion material](#materials) will describe how to use the following techniques to calibrate observed data using trajectory matching.

* Relate simulations of specific model variables to observed versions of those variables.
* Model over-dispersion using the negative-binomial distribution.
* Manipulate optimizer settings when troubleshooting lack of convergence.
* Determining whether the data provide information about a parameter of interest.
* Transforming parameters to be calibrated so that the optimizer doesn't converge on impossible values (e.g. calibrating the log of the transmission rate will ensure that the transmission rate is positive).

<!-- omit from toc -->
#### Calibrate Initial State Variables

The [companion material](#materials) will describe how to calibrate the initial values of the state variables using the following techniques.

* Simple expressions involving the total population size, `N` (e.g., initializing `S` as `N` minus the initial sum of the infectious and exposed classes).
* Optimizing the initial values of selected state variables based on fit to the data (e.g., estimate numbers of individuals that were already recovered, `R`, by the time data collection started).
* Estimating the distribution of exposed and infectious individuals among compartments in stratified models at the beginning of an epidemic. This is useful for addressing convergence issues caused by dynamical instability.



<!-- omit from toc -->
### Making Inferences

Participants will learn how to make the following types of inferences using realistically parameterized models.

- [ ] Visualizing goodness-of-fit.
- [ ] Generating confidence intervals for estimated parameters.
- [ ] Forecasting model variables beyond the last data point.
- [ ] Calculating prediction intervals measuring uncertainty about these forecasts.
- [ ] Comparing alternative scenarios for counter-factual causal analysis (e.g., how many deaths were saved due to vaccination).
- [ ] Produce uncertainty estimates for [epidemiological model summaries](#epidemiological-model-summaries) like $\mathcal{R}_0$.


<!-- omit from toc -->
### Adding Model Structure

Population Structure Library The pathogen models in our library will be complemented by a library of population structures, including tools for analyzing age-structured mixing, travel, hospitalization and other isolation scenarios, and socio-economic status. We will use a modular approach that will allow our pathogen models to be combined with one or more population structures to rapidly produce appropriate models for a particular context.


* boxes for tracking symptom status or biomarkers
* We will also provide tools to incorporate different assumptions (or information) about test reliability.


## Outcomes

## Schedule

| Time        | Activity                              |
| ----------- | ------------------------------------- |
| 8:00-9:00   | **Registration and Breakfast**        |
| 9:00-9:15   | **Welcome and Introduction**          |
| 9:15-10:30  | **Session 1: Model Exploration**      |
| 10:30-10:45 | **Break**                             |
| 10:45-12:00 | **Session 2: Parameterization**       |
| 12:00-1:00  | **Lunch**                             |
| 1:00-2:15   | **Session 3: Making Inferences**      |
| 2:15-2:30   | **Break**                             |
| 2:30-3:45   | **Session 4: Adding Model Structure** |
| 3:45-4:00   | **Break**                             |
| 4:00-5:15   | **Session 5: Make your own Model**    |
| 5:15-5:30   | **Wrap-up and Closing Remarks**       |


## Preparation

<!-- omit from toc -->
### Required Preparation

Participants **must** take the following steps to prepare for the workshop.

* Successfully install `macpan2` using these [instructions](https://canmod.github.io/macpan2#installation).
* TODO: Installation of supporting packages -- includes at least `dplyr`, `ggplot2`, `tidyr`, `broom.mixed` -- How exhaustive do we want to be here?
* Successfully run the `macpan2` [hello world](https://canmod.github.io/macpan2#hello-world) programme.

<!-- omit from toc -->
### Suggested Preparation

Participants **should** take the following steps to prepare for the workshop.

* Sketch a state-transition diagram for a [compartmental model](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology) that is of interest to you; preferably one that you use or would like to use in your own work.
* Be prepared to load in some data that are relevant for this model.
* Try using the [companion material](#materials) to take their model through the [model refinement cycle](#background).
* Take a look at the [tidyverse](https://www.tidyverse.org), which is a data analysis framework and set of packages in `R` with which `macpan2` is designed to work.

<!-- omit from toc -->
### Optional Preparation

Participants **could** take the following steps to prepare for the workshop.

* Install [RStudio](https://www.rstudio.com/categories/rstudio-ide/) if they have not already done so, as I will be using RStudio during the workshop. But facility with another program for creating R scripts is fine.


## Footnotes

[^Rfamiliarity]: Although participants familiar with [R](https://www.r-project.org/) will be more comfortable with the material, familiarity will not be assumed.

[^milestones]: To be produced in a subsequent milestone.

[^tidyverse]: We will use the `R` [tidyverse](https://www.tidyverse.org/) for data preparation and visualization.
