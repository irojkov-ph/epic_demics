# epic_demics/src
Here you will find the source code written of the project. <br>
This project is written in MatLab &copy;.
The structure of the code is as following:

```
  start.m
    |
    |--- compare_config.m
    |
    |--- system_init.m
    |
    |--- evolve_system.m
    |         |
    |         |--- step.m
    |         |      |
    |         |      |--- evolution_illness.m
    |         |      |             |
    |         |      |             |--- evolve_cell.m
    |         |      |             |          |
    |         |      |             |          |--- beta_influenza.m
    |         |      |             |          |--- mu_age.m
    |         |      |             |          |--- density_ill.m
    |         |      |             |          |--- update_ages.m
    |         |      |             |          
    |         |      |             |--- displacement.m
    |         |      |                        |
    |         |      |                        |--- switch_cells.m
    |         |      |
    |         |      |--- evolution_vaccination.m
    |         |
    |         |--- draw.m
    |
    |--- finish.m
```