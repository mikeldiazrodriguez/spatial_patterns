# Less is More? Testing the Impact of Environmental Variable Refinement on Palaeolithic Site Location Models
This repository contains data and code to enable reproducibility of the paper: Díaz-Rodríguez, M.<a href="https://orcid.org/0000-0002-2703-1507">
<img alt="ORCID logo" src="https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png" width="14" height="14" />
</a>. (Forthcoming). "Less is More? Testing the Impact of Environmental Variable Refinement on Palaeolithic Site Location Models". Journal of Archaeological Method and Theory.

## Repository structure
/csv/*.csv ... contains CSV files with the data to elaborate some statistical analysis.

/figures ... folder with the figures used in the paper in PNG format.

/grids/ ... folder with the layers of the covariates used in the study.

/output/ ... folder with the output files in PNG and PDF format.

/shp/ ... folder with the layers of the sites, the random points and the study areas in vector format.

/sm/ ... folder with a supplementary information appendix and some extra information.

code_sp.html ... html file to reproduce the analysis.

code_sp.Rmd ... Rmarkdown file to reproduce the analysis.

## R Packages used
[dismo](https://cran.r-project.org/web/packages/dismo/dismo.pdf) - Methods for species distribution modelling.

[geostatsp](https://rdrr.io/cran/geostatsp/) - Geostatistical Modelling with Likelihood and Bayes.

[GGally](https://cran.r-project.org/web/packages/GGally/index.html) - This package is a plotting system based on the grammar of graphics.

[ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) - Package for creating graphics.

[maps](https://cran.r-project.org/web/packages/maps/index.html) - Display of maps.

[maptools](https://cran.r-project.org/web/packages/maptools/index.html) - Set of tools for manipulating geographic data.

[MASS](https://cran.r-project.org/web/packages/MASS/MASS.pdf) - Functions and datasets to support Venables and Ripley.

[sf](https://cran.r-project.org/web/packages/sf/index.html) - Simple Features for R. Provides classes and methods for handling vector spatial data.

[sp](https://cran.r-project.org/package=sp) - Package for spatial data.

[raster](https://cran.r-project.org/web/packages/raster/index.html) - Reading, writing, manipulating, analysing and modelling of spatial data.

[terra](https://cran.r-project.org/package=terra) - Main package for handling raster data.

[spatstat](https://cran.r-project.org/web/packages/spatstat/index.html) - Toolbox for analysing Spatial Point Patterns.

[spatstat.geom](https://cran.r-project.org/package=spatstat.geom) - Provides the fundamental geometric structures for point pattern analysis.

[spatstat.convert](https://cran.r-project.org/package=spatstat.convert) - Facilitates conversion between sf/terra objects and native spatstat structures.

[GGally](https://cran.r-project.org/package=GGally) - Used to generate correlation matrices and pairwise plots for exploratory variable analysis.

[writexl](https://cran.r-project.org/package=writexl) - Allows exporting model results to Excel files.

[dplyr](https://cran.r-project.org/package=dplyr) - Provides an intuitive grammar of verbs for fast, efficient data manipulation.

[broom](https://cran.r-project.org/package=broom) - Converts messy statistical model outputs into clean, tidy data frames for easy analysis and visualisation.

[tidyterra](https://cran.r-project.org/package=tidyterra) - Integrates tidyverse workflows with terra spatial objects.

[ggplot2](https://cran.r-project.org/package=ggplot2) - Package designed to create highly customizable, multilayered plots based on the Grammar of Graphics.

[foreach](https://cran.r-project.org/package=foreach) - Provides a flexible looping construct designed to execute expressions repeatedly.

[tibble](https://cran.r-project.org/package=tibble) - Gives a modern version of data frames.

[magrittr](https://cran.r-project.org/package=magrittr) - Provides the %>% operator for chaining data manipulation operations.

[brglm2](https://cran.r-project.org/package=brglm2) - Implements Firth's bias-reduced logistic regression.

[pROC](https://cran.r-project.org/package=pROC) - Used to calculate AUC and ROC curves.

[patchwork](https://cran.r-project.org/package=patchwork) - Allows combining multiple ggplot2 plots into a single figure easily and intuitively.

[cowplot](https://cran.r-project.org/web/packages/cowplot/index.html) - ggplot2 extension in R designed to easily combine and annotate multiple plots.

[ggspatial](https://cran.r-project.org/package=ggspatial) - Simplifies geospatial data visualisation.

[virtualspecies](https://cran.r-project.org/package=virtualspecies) - R package to generate virtual species distributions.

[onpoint](https://cran.r-project.org/package=onpoint) - Provides auxiliary functions for point pattern analysis.

### References about the packages

Bache, S. M., & Wickham, H. (2022). magrittr: A Forward-Pipe Operator for R.

Baddeley, A. J., Turner, R., & Rubak, E. (2025). spatstat.convert: Extension to ‘spatstat’ for Converting Data Formats.

Baddeley, A., Turner, R., & Rubak, E. (2025). spatstat.geom: Geometrical Functionality of the ‘spatstat’ Family.

Baddeley, Adrian, Turner, R., & Rubak, E. (2020). spatstat: Spatial Point Pattern Analysis, Model-Fitting, Simulation, Tests.

Daniel, F., Ooi, H., Calaway, R., Microsoft, & Weston, S. (2022). foreach: Provides Foreach Looping Construct.

Dunnington, D. (2023). ggspatial: Spatial Data Framework for ggplot2.

Hernangómez, D. (2023). Using the tidyverse with terra objects: the tidyterra package. Journal of Open Source Software, 8(91), 5751. https://doi.org/10.21105/joss.05751

Hesselbarth, M. H. K. (2025). onpoint: Helper Functions for Point Pattern Analysis. https://doi.org/10.32614/CRAN.package.onpoint

Hijmans, R. J., Barbosa, M., Bivand, R., Brown, A., Chirico, M., Cordano, E., et al. (2025). terra: Spatial Data Analysis.

Hijmans, Robert J. (2023). raster: Geographic Data Analysis and Modeling.

Kosmidis, I. (2026). brglm2: Bias Reduction in Generalized Linear Models.

Leroy, B., Meynard, C. N., Bellard, C., & Courchamp, F. (2016). virtualspecies, an R package to generate virtual species distributions. Ecography, 39(6), 599–607. https://doi.org/10.1111/ecog.01388

Müller, K., & Wickham, H. (2023). tibble: Simple Data Frames.

Ooms, J., & Denney, B. (2025). writexl: Export Data Frames to Excel ‘xlsx’ Format.

Pebesma, E., & Bivand, R. (2023). Spatial Data Science: With applications in R. Chapman and Hall/CRC. https://doi.org/10.1201/9780429459016

Pebesma, Edzer, & Bivand, R. (2005). Classes and methods for spatial data in R. R News, 5(2), 9–13.

Pedersen, T. L. (2022). patchwork: The Composer of Plots.

Robin, X., Turck, N., Hainard, A., Tiberti, N., Lisacek, F., Sanchez, J.-C., & Müller, M. (2011). pROC: an open-source package for R and S+ to analyze and compare ROC curves. BMC Bioinformatics, 12, 77.

Robinson, D., Hayes, A., & Couch, S. (2023). broom: Convert Statistical Objects into Tidy Tibbles.

Schloerke, B., Cook, D., Larmarange, J., Briatte, F., Marbach, M., Thoen, E., et al. (2025). GGally: Extension to ‘ggplot2’. https://doi.org/https://ggobi.github.io/ggally/

Wickham, H., François, R., Henry, L., Müller, K., & Vaughan, D. (2023). dplyr: A Grammar of Data Manipulation. https://doi.org/10.32614/CRAN.package.dplyr

Wickham, Hadley, Chang, W., Henry, L., Pedersen, T. L., Takahashi, K., Wilke, C., et al. (2020). ggplot2: Create Elegant Data Visualisations Using the Grammar of Graphics.

Wilke, C. O. (2024). cowplot: Streamlined Plot Theme and Plot Annotations for ‘ggplot2’.


## Source code and data reference
Mikel Díaz-Rodríguez<a href="https://orcid.org/0000-0002-2703-1507">
<img alt="ORCID logo" src="https://info.orcid.org/wp-content/uploads/2019/11/orcid_16x16.png" width="14" height="14" />
</a>. (2026, October 28). Living in the Mountains. Settlement patterns in Northwestern Iberia during the Palaeolithic period. Source code and data. Zenodo. https://zenodo.org/doi/10.5281/zenodo.10142401
