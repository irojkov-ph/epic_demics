# epic_demics

Epic_Demics is a MATLAB &copy; (The MathWorks, Inc.) project and is part of the Agent-Based Modeling and Social System Simulation course (Fall 2019) of ETH Zürich [1].

## Autors

 - Group name : Epic Demics
 - Group members : Nicholas Delmotte [@nicdel-git](https://github.com/nicdel-git), Loris Pedrelli [@lpedrelli](https://github.com/lpedrelli), Ivan Rojkov [@irojkov-ph](https://github.com/irojkov-ph)
 - Project title : A study of the effect of vaccination on an agent-based stochastic SIRS model

## Introduction
On the 11th of March 2019, the World Health Organisation (WHO) launched the Global Influenza Strategy for 2019-2030 aimed at preventing seasonal influenza with vaccines, controlling the spread of influenza from animals to humans and preparing for the next influenza pandemics. Seasonal influenza (commonly called flu) is a viral disease which affects worldwide about 3 to 5 million people and causes about 290'000 to 650'000 respiratory deaths per year [2]. In this report the effect of vaccines and the importance of collective vaccination behaviour will be studied by implementing an SIRS model mixed with an agent based model which simulates the human interaction between neighbours. This localised interaction allows us to study the spreading of the disease with regards to the topology the system. To do so, some characteristic quantities of the system, and of its agents, will be defined and then their behaviour will be studied under the variation of different parameters of the model.

## Model

This project implements an agent-based stochastic model for SIRS epidemics. SIRS stands for Susceptible-Infected-Recovered-Susceptible and represents the three agent states existing in the system as well as the viral dynamic between them. In other words, a recovered agent from the infected state can with a certain probability become susceptible again.
The model is organised as following: starting from a given time, the illness evolves locally during a period of one week (i.e. time unit = week). Then all agents take their vaccination choice depending on their situation and the rewards of their neighbours. Finally, the illness is simulated for another week and so on. The simulation ends after a given number of decision steps (cf. the report for further details).

## Reproducibility

For the purpose of reproducibility, we make this project public. You can either download the project or clone it directly using git as following:
```
git clone https://github.com/irojkov-ph/epic_demics.git
```
Then open MATLAB &copy; in the right folder and enter the following commands in the command line:
```
cd epic_demics
main
```
This command will execute a basic simulation. For other particular simulations you can either decomment the appropriate section in the `main.m` script or create your own simulation as following:
```
addpath(['.',filesep,'src',filesep]);
config.parameter1 = value1;
config.parameter2 = value2;
...
start(config);
```
Where [`parameter`,`value`] couples are the values of different parameter implemented in the project. <br>
To stop a simulation just press `CRTL+C` in the MATLAB &copy; command line.

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
| Rate at which the vaccin <br>becomes ineffective  | alpha          | `config.alpha`             | 1/(4*6)       |
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

[2] Ask the expert: Influenza Q&A, _WHO - Influenza (Seasonal)_,  6 November 2018, <br> url:[https://www.who.int/en/news-room/fact-sheets/detail/influenza-(seasonal)](https://www.who.int/en/news-room/fact-sheets/detail/influenza-(seasonal)), Last consulted 03.12.2019.
 






