# epic_demics

Epic_Demics is a MATLAB &copy; (R2019b, The MathWorks, Inc.) project and is part of the Agent-Based Modeling and Social System Simulation course (Fall 2019) of ETH Zürich [1].

## Autors

 - Group name : Epic Demics
 - Group members : Nicholas Delmotte [@nicdel-git](https://github.com/nicdel-git), Loris Pedrelli [@lpedrelli](https://github.com/lpedrelli), Ivan Rojkov [@irojkov-ph](https://github.com/irojkov-ph)
 - Project title :  

## Introduction
The 11th of March the World Health Organisation (WHO) launched the Global Influenza Strategy for 2019-2030 aimed at preventing seasonal influenza with vaccines, control the spread of influenza from animals to humans and prepare for the next influenza pandemics. Seasonal influenza (commonly called flu) is a viral disease which affects worldwide about 3 to 5 million people and causes about 290'000 to 650'000 respiratory deaths [2]. In this report the effect of vaccine and the importance of collective behaviour in front of the decision whether to vaccinate or not will be studied by implementing a SIRS model mixed with an agent based model which simulates the social human behaviour.

## Model

## Reproductibility

## File structure

## Parameters that can be simulated

| Description                                       | Abbreviation   | In the config parameter    | Default value | 
|---------------------------------------------------|:--------------:|:--------------------------:|:-------------:|
| Number of cells along <br> one side of the system | nb_cell        | `config.nb_cell`           | 50            |
| Number of decision steps                          | N              | `config.nb_decision_step`  | 50            |
| <br>                                              |                |                            |               |
| Allow agents to vaccinate themself                | vaccination    | `config.vaccination`       | true          |
| Allow agents to move in the system                | dynamic        | `config.dynamic`           | false         |
| <br>                                              |                |                            |               |
| Infection rate                                    | beta           | `config.beta`              | NaN           |
| Recovery rate                                     | gamma          | `config.gamma`             | NaN           |
| Rate at which becomes <br> ineffective            | alpha          | `config.alpha`             | 1/(4*6)       |
| Mortality rate                                    | mu             | `config.mu`                | NaN           |
| Rate of zero event <br> (nothing happens event)   | zero           | `config.zero`              | 1             |
| <br>                                              |                |                            |               |
| Getting infected reward                           | r_ill          | `config.r_ill`             | -10           |
| Recovery reward                                   | r_recover      | `config.r_recovery`        | 2             |
| Vaccination reward                                | r_vacc         | `config.r_vacc`            | -4            |
| <br>                                              |                |                            |               |
| Patient zero coordinates                          | patient zero   | `config.patient_zero_coord`| NaN           |


cf. `./src/compare_config.m` file for further details

## Refereces

[1] Agent-Based Modeling and Social System Simulation, _Computational Social Science_, ETH Zürich, <br>  url:[https://coss.ethz.ch/education/agentBased.html](https://coss.ethz.ch/education/agentBased.html)

[2] Ask the expert: Influenza Q&A, _WHO - Influenza (Seasonal)_,  6 November 2018, <br> url:[https://www.who.int/en/news-room/fact-sheets/detail/influenza-(seasonal)](https://www.who.int/en/news-room/fact-sheets/detail/influenza-(seasonal)), Last consulted 03.12.2019








