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
    |         |      |             |          |--- update_ages.m
    |         |      |             |          |--- density_ill.m
    |         |      |             |                     |
    |         |      |             |                     |--- nearest_neighbours.m
    |         |      |             |          
    |         |      |             |--- displacement.m
    |         |      |                        |
    |         |      |                        |--- nearest_neighbours.m
    |         |      |                        |--- count_nearest_neighbours.m
    |         |      |                        |--- switch_cells.m
    |         |      |
    |         |      |--- evolution_vaccination.m
    |         |
    |         |--- draw.m
    |
    |--- finished.m
```