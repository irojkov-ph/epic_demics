# epic_demics
This repository is made for a group project in the context of the Agent-Based Modeling and Social System Simulation course of ETH Zürich. 

The theme of this project is Epidemics & Immunizations

It is a project mainly written in MatLab and it will be developped during the following weeks.


## Introduction


## Model

## Reproductibility

## File structure

## Parameters that can be simulated

| Description                                       | Abbreviation   | In the config parameter    | Default value | 
|---------------------------------------------------|:--------------:|:--------------------------:|:-------------:|
| Infection rate                                    | beta           | `config.beta`              | NaN           |
| Recovery rate                                     | gamma          | `config.gamma`             | NaN           |
| Rate at which becomes <br> ineffective            | alpha          | `config.alpha`             | 1/(4*6)       |
| Mortality rate                                    | mu             | `config.mu`                | NaN           |
| Rate of zero event <br> (nothing happens event)   | zero           | `config.zero`              | 1             |

| Getting infected reward                           | r_ill          | `config.r_ill`             | -10           |
| Recovery reward                                   | r_recover      | `config.r_recovery`        | 2             |
| Vaccination reward                                | r_vacc         | `config.r_vacc`            | -4            |

| Number of cells along <br> one side of the system | nb_cell        | `config.nb_cell`           | 50            |
| Number of decision steps                          | N              | `config.nb_decision_step`  | 50            |

| Allow agents to vaccinate themself                | vaccination    | `config.vaccination`       | true          |
| Allow agents to move in the system                | dynamic        | `config.dynamic`           | false         |

| Patient zero coordinates                          | patient zero   | `config.patient_zero_coord`| NaN           |

cf. './src/compare_config.m' file for further details

## Refereces











