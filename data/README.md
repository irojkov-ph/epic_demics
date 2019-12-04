# epic_demics/data
Here you will find data produced by your simulations.
Data formats are as following:
   * `"name"_"timestamp"_system.mat` : binary MATLAB files that store the system structure.
      - "name" is the name of the simulation defined in `system.cfg.name`.
      - "timestamp" is the Unix timestamp when the simulation finished.
   * `"name"_"timestamp"_"todraw".fig` : MATLAB figure files (only for use with MATLAB, for other formats open FIG-files and save it appropriately)
      - "todraw" is the name of the figure that was drawn during the simulation, you can find names of all the produced figures during the simulation in `system.cfg.todraw`
      

