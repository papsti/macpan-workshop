<!-- omit from toc -->
# Using `macpan2`

This is a (currently draft) syllabus for a workshop on using [`macpan2`](https://canmod.github.io/macpan2) for applied public health modelling.

<!-- omit from toc -->
## Table of Contents
- [Instructor](#instructor)
- [Audience](#audience)
- [Background](#background)
- [Objectives](#objectives)
- [Outcomes](#outcomes)
- [Schedule](#schedule)
- [Preparation](#preparation)
- [Footnotes](#footnotes)


## Instructor

Steve Walker 

swalk@mcmaster.ca

https://github.com/stevencarlislewalker


## Audience

We assume that workshop participants are professional epidemiological modellers who use, or want to use, compartmental models to address public health issues. The material is specifically tailored to such modellers at the public health agency of Canada.

Although participants familiar with [R](https://www.r-project.org/) will be more comfortable with the material, we will not assume any such familiarity. We will however assume that participants have at least a little experience coding to solve scientific problems.

## Background

Applied compartmental modelling is a multi-faceted topic. We conceive of the following model refinement cycle, as the key aspect of applied compartmental modelling for which `macpan2` is designed. In this workshop we will strongly encourage modellers to follow the steps in this cycle in their own work.

![modeling-cycle](modelling-cycle.svg)

We have learned from our experience in applied public health modelling that it is better to close the loop as quickly as possible, rather than try to produce the perfect model outright. Keeping the scope of each step as limited as possible is useful for avoiding [analysis paralysis](https://en.wikipedia.org/wiki/Analysis_paralysis). Every time we get back to the **infer** step we have another chance of providing valuable inputs to the public health debate, and so we want to do this as often as possible. And if we neither skip nor linger on any of the steps since the last set of inferences were made, we are more likely to have both a clear and simple description of how and why the inferences were made.

We stress the importance of data and other external inputs into the modelling process. This is applied modelling for specific real-world problems, and so none of the steps can be completely abstract. We have found that modelling issues that are well-understood abstractly (e.g. we do not really need another measles model to tell us that we need more vaccination), it is often worth expressing such near-universal truths as models of the specific population of concern.

## Objectives

The overall goal of the workshop is to train epidemiological modellers to use the `macpan2` software in their efforts to use compartmental modelling to support public health. Specific workshop goals can be categorized as part of a particular step within the above model refinement cycle.

<!-- omit from toc -->
### Model Exploration

Participants will learn how to do the following.

* Find candidate models in the `macpan2` [library](https://canmod.github.io/macpan2/articles/example_models) of starter models.
* Prepare relevant data so that it can be compared with `macpan2` simulation output, both visually and numerically.[^1]
* Make modifications to models in the library.
* Compute epidemiological summaries ($\mathcal{R}_0$, $\mathcal{R}_t$, and moments of the generation interval distribution).
* Choose how the dynamical system is solved (e.g., discrete-time recursion, ODE solvers, stochastic simulation).

Although every emerging pathogen has a unique set of characteristics, there typically exist disease models that can serve as starting points in a crisis situation. The `macpan2` library of candidate models includes (TODO: or will include when the workshop is given) a variety of pathogens that cover the range of likely characteristics for emerging threats.

* Seasonal respiratory illnesses (e.g., influenza, COVID-19, RSV).
* Measles and other childhood infections.
* Ebola and pneumonic plague.
* Sexually transmitted diseases like HIV and MPox.
* Vector-mediated pathogens like dengue, Zika, and bubonic plague.
* Reemerging pathogens due to increased levels of antimicrobial resistance (e.g., drug resistant Group A Streptococcus, i.e. Scarlet fever).


Participants will learn how to prepare the following types of data for comparisons with model simulations, or to quickly find and use instructions for preparing them.

* Case, symptom, and outcome reports.
* Hospital admissions and occupancy.
* Seroprevalence.
* Cell phone mobility data.
* Genomic data on the relative abundance of pathogen strains.
* Wastewater pathogen concentrations.
* Social attitude data (e.g., vaccine hesitancy)
* Operational and intervention schedules (e.g., vaccination supply, school closures)


Participants will learn how to make the following modifications, or to quickly find and use instructions for making them.

* Add/remove compartments or flows amongst compartments (e.g., a compartment for pathogen concentration in wastewater).
* Filter numbers of cases to account for reporting delays, under-reporting, and weekend effects.
* Add schedules of parameter variation in response to exogeneous factors (e.g. transmission rate in response to lockdowns, vaccine supply).
* Add stochasticity in rates of transition among compartments.


<!-- omit from toc -->
### Parameterization

Participants will learn how to do the following.

* Modify the default values of parameters in a model.
* Express uncertainty in parameters with prior distributions.
* Parameterize the initial values of the state variables (e.g. `S`, `I`) so that they can be optimized.
* Use optimization to calibrate parameters so that the discrepancy between observed and simulated data is minimized.
* Flexibly model unknown time-variation of parameters using machine learning sub-models.

<!-- omit from toc -->
### Making Inferences

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

Participants **must** take the following steps to prepare for the workshop.

* Successfully install `macpan2` using these [instructions](https://canmod.github.io/macpan2#installation).
* TODO: Installation of supporting packages -- includes at least `dplyr`, `ggplot2`, `tidyr`, `broom.mixed` -- How exhaustive do we want to be here?
* Successfully run the `macpan2` [hello world](https://canmod.github.io/macpan2#hello-world) programme.



Participants **should** take the following steps to prepare for the workshop.

* Sketch a flow diagram for a [compartmental model](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology) that is of interest to you; preferably one that you use or would like to use in your own work.

Participants **could** take the following steps to prepare for the workshop.

* Install [RStudio](https://www.rstudio.com/categories/rstudio-ide/) if they have not already done so, as I will be using RStudio during the workshop. But facility with another program for creating R scripts is fine.


## Footnotes

[^1]: We will use the `R` [tidyverse](https://www.tidyverse.org/) for data preparation.

