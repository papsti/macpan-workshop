<!-- omit from toc -->
# Syllabus

[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

This is a syllabus for a workshop on using [`macpan2`](https://canmod.github.io/macpan2) for applied public health modelling.

<!-- omit from toc -->
## Table of Contents
- [Instructor](#instructor)
- [Audience](#audience)
- [Flow](#flow)
- [Schedule](#schedule)
- [Background](#background)
- [Objectives](#objectives)
- [Outcomes](#outcomes)
- [Preparation](#preparation)


## Instructor

Steve Walker  –  [swalk@mcmaster.ca](mailto:swalk@mcmaster.ca)  –  [github.com/stevencarlislewalker](https://github.com/stevencarlislewalker)

I'm not an epidemiological modeller. I've been working on computational statistics for about 20 years. I got my PhD in Ecology in 2010, and I've worked in academic, industry, and government settings.

## Audience

We assume that workshop participants are epidemiological/disease modellers who use, or want to use, compartmental models to address public health issues. The material is specifically tailored to such modellers at the [Public Health Agency of Canada](https://www.canada.ca/en/public-health.html).

Details on how to prepare for the workshop are covered [here](#preparation).

## Flow

During the workshop, we will alternate between conceptual discussions and hands-on exercises to explore key techniques. We recognize that participants will have different levels of experience, so some exercises may feel more challenging than others. However, conceptual discussions will not depend on completing prior exercises. Some participants may focus on translating compartmental model diagrams into simulations, while others may want to delve into the details of optimization and ODE solvers. Hands-on sessions will be flexible, allowing participants to pursue their interests, while conceptual discussions will be structured and scheduled.

## Schedule

The workshop will take place on March 20, 2025 with the following schedule.

| Time        | Activity                      |
| ----------- | ----------------------------- |
| 10:00-10:15 | **Welcome and Introduction**  |
| 10:15-11:00 | **Session 1a: Exploration**   |
| 11:00-11:15 | **Break**                     |
| 11:15-12:00 | **Session 1b: Exploration**   |
| 12:00-1:00  | **Lunch**                     |
| 1:00-1:45   | **Session 2: Calibration**    |
| 1:45-2:00   | **Break**                     |
| 2:00-2:45   | **Session 3: Inference**      |
| 2:45-3:00   | **Break**                     |
| 3:00-3:30   | **Session 4: Stratification** |
| 3:30-3:45   | **Feedback**                  |
| 3:45-4:00   | **Finishing and Packing Up**  |

## Background

The [`macpan2`](https://canmod.github.io/macpan2) package is a flexible compartmental modelling tool that has been optimized for fast calibration to data.  This package grew out of lessons learned developing the [McMasterPandemic](https://github.com/mac-theobio/McMasterPandemic) COVID-19 model, which was used to support public health during the pandemic.

Applied compartmental modelling is a big topic. The following activities describe the aspects of this topic for which `macpan2` is designed.

* **Exploration**: Compare simulations freely under alternative parameter sets, and with real and/or hypothetical data.
* **Calibration**: Refine default parameters for a specific population and question, possibly by formally calibrating parameters with data.
* **Inference**: Use calibrated models to make inferences (e.g. confidence intervals for parameters, forecasts, counter-factuals). 
* **Stratification**: Separate individuals in one compartment into many (e.g. by age, space, vaccination status) and/or find stratified data.

<!-- omit from toc -->
#### Example Workflow

Starting with exploration, and then iterating within the following model refinement cycle, can be a good default workflow for applied public health compartmental modelling projects.

```mermaid
graph LR;
    Exploration-->Calibration;
    Calibration-->Inference;
    Inference-->Stratification;
    Stratification-->Exploration;
```
In this cycle, exploration can clarify if existing parameter values need refinement. In turn, calibration refines a model so that it can be used to make defensible inferences in a specific context. Inferences can raise questions about whether a model should be stratified to make it more realistic. Finally, stratification can create new model behaviours that may require further exploration, starting the cycle over again.

In applied public health modeling, iterative cycles can be completed at different paces, depending on the context and objectives. A rapid approach, focusing on completing each iteration efficiently rather than aiming for a fully refined model upfront, can sometimes help maintain momentum. Limiting the scope of each step, or occasionally omitting less critical steps, may help mitigate delays associated with extensive analysis. Returning to the inference step frequently provides opportunities to refine insights and contribute to ongoing public health discussions.

The stratification step will increase model complexity, which has both advantages and disadvantages. Therefore, complexity will tend to increase as a modelling project iterates through the cycle. Starting with a simple model will help ensure that the project converges on an appropriate level of complexity. Sometimes it is worth resetting the cycle by starting again with a simpler model.

We will use this model refinement cycle to provide context when concepts are introduced in the workshop. The instructor will take a modelling example through one cycle during the workshop. Participants will be given time to try some of these techniques on their own models.

## Objectives

The overall goal of the workshop is to introduce epidemiological modellers to the `macpan2` software for compartmental modelling to support public health. Each [session](#schedule) will cover techniques associated with one of the steps in the [model refinement cycle](#background).

There will not be enough time in the workshop to cover all of `macpan2`, so there will be a companion set of online materials that will cover more of the available options.


<!-- omit from toc -->
#### Session 1: Exploration

Participants will learn about the following types of tasks required for exploring model simulations.

* Find simulation models in the `macpan2` [library](#library-models) of starter models.
* Create simulation models from scratch.
* Run, summarize, and visualize simulations.
* Identify sets of model quantities to be calibrated.
* Describe the relationships between the values of parameter inputs and simulated outputs.
* Prepare certain [types of data](#types-of-data) so that they can be compared with `macpan2` simulation output, both visually and numerically.
* Make [modifications to models](#model-modification-tools) in the library.
* Understand the mathematics behind simulation models.
* Cast a model as a particular [dynamical model type](#dynamical-model-types) (e.g. discrete-time recursion, ordinary differential equation).


<!-- omit from toc -->
#### Session 2: Calibration

Participants will learn about the following types of tasks required for parameterizing models, for exploring scenarios and making inferences and predictions about a particular population and public health problem.

* Use [optimization](#optimization) to calibrate parameters (e.g., transmission rate) so that the discrepancy between observed and simulated data is minimized.
* Apply basic troubleshooting techniques when optimization fails.
* Express uncertainty in model parameters (e.g., transmission rate) with prior distributions.
* Calibrate the functional form of time-variation of parameters.


<!-- omit from toc -->
#### Session 3: Inference

Participants will learn about the following types of tasks that are often necessary when making inferences using calibrated models.

* Visualize goodness-of-fit.
* Generate confidence intervals for estimated parameters.
* Deciding when to refine parameter calibrations
* Forecast model variables beyond the last data point.
* Calculate prediction intervals measuring uncertainty about these forecasts.
* Compare alternative scenarios for counter-factual causal analysis (e.g., how many deaths were saved due to vaccination?).

<!-- omit from toc -->
#### Session 4: Stratification

Participants will learn about the importance of stratification of simple compartmental models. We will not do anything hands on in this session.

* Stratify every compartment in the same way (e.g. by age, location).
* Stratify infectious compartments (e.g. by symptom status).
* Expand a single compartment into a sequential chain, to model different distributions of time spent in that compartment.
* Combine several single-strain models into a single multi-strain model.
* Stratify compartments based on immunity status. This is particularly useful in cases where immunity is partial, can wane, and is caused by a mixture of past infection, vaccination, and cross-immunity.

## Outcomes

After participating in the workshop, modellers will be able to do the following.

* Determine if compartmental modelling is an appropriate tool for a particular applied public health problem.
* Use `macpan2` to create a simple compartmental model for a real public health problem.
* Navigate the [documentation](https://canmod.github.io/macpan2) to learn how to solve compartmental modelling problems that `macpan2` is able to solve.
* Suggest improvements to `macpan2`.

## Preparation

* Follow the [technical preparation](https://canmod.github.io/macpan-workshop/technical-preparation) document to ensure that your computer is ready for the workshop.
* Read the [video resources](https://canmod.github.io/macpan-workshop/video-resources) document and prioritize watching the first three videos giving background on the macpan2 software.
