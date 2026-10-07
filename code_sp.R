# install and load multiple R packages.
# check to see if packages are installed. Install them if they are not, then load them into the R session.

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
# usage
packages <- c("sf", "mapview", "spatstat.geom", "GGally", "ggplot2", "writexl",
              "dplyr", "broom", "purrr", "terra",
              "foreach", "tibble", "magrittr", "tidyr")
ipak(packages)

# set your working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/shp")

# add the study areas
area_monforte  <- st_read("area_monforte.shp")
area_northern  <- st_read("area_northern.shp")
area_central   <- st_read("area_central.shp")

# add the sites
sitesSubM <- st_read("sites_monforte.shp")
sitesSubN <- st_read("sites_northern.shp")
sitesSubC  <- st_read("sites_central.shp")

# add the random sites
random_sites_monforte <- st_read("random_sites_monforte.shp")
random_sites_northern <- st_read("random_sites_northern.shp")
random_sites_central  <- st_read("random_sites_central.shp")

# set a window for each area
window_monforte <- as.owin(area_monforte)
window_north    <- as.owin(area_northern)
window_central  <- as.owin(area_central)

# create a ppp object
sitesSubM.ppp <- ppp(x = sitesSubM$UTMX, y = sitesSubM$UTMY, window = window_monforte)
sitesSubN.ppp <- ppp(x = sitesSubN$utmx, y = sitesSubN$utmy, window = window_north)
sitesSubC.ppp <- ppp(x = sitesSubC$utmx, y = sitesSubC$utmy, window = window_central)

# CSR Analysis
## Monforte de Lemos basin
### Normality test for sites
shapiro.test(sitesSubM$UTMX)

### Normality test for random sites
shapiro.test(random_sites_monforte$UTMX)

### If the alternative hypothesis is accepted, the points do not follow a normal distribution. To verify this, the K-S Test is used.
### K-S is a non-parametric test to check if the points of both samples belong to the same population.
ks.test(sitesSubM$UTMX,random_sites_monforte$UTMX)


## Northern Mountain ranges
### Normality test for sites
shapiro.test(sitesSubN$utmx)

### Normality test for random sites
shapiro.test(random_sites_northern$utmx)

### If the alternative hypothesis is accepted, the points do not follow a normal distribution. To verify this, the K-S Test is used.
### K-S is a non-parametric test to check if the points of both samples belong to the same population.
ks.test(sitesSubN$utmx,random_sites_northern$utmx)


## Central Mountain ranges
### Normality test for sites
shapiro.test(sitesSubC$utmx)

### Normality test for random sites
shapiro.test(random_sites_central$utmx)

### K-S Test
ks.test(sitesSubC$utmx,random_sites_central$utmx)



# Person’s Correlation function
## change your working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/csv")

# import data
dat_monf  <- read.table("dat_monf.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE)
dat_north <- read.table("dat_north.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE)
dat_cent  <- read.table("dat_cent.csv", header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE)

vars <- c("altitude", "wetland_cost", "goat_cost", "geology_cost", 
          "hydrology_cost", "lcp_cost", "eucl_dist_geo", "eucl_dist_hydro",
          "dif_ins", "dir_ins", "tot_ins", "aspect", "slope", 
          "vis_prom", "tpi100", "tpi500", "tpi1000", "wind")


# Data
sample_monf  <- dat_monf[, vars]
sample_north <- dat_north[, vars]
sample_cent  <- dat_cent[, vars]

# Check correlations
cor(sample_monf)
cor(sample_north)
cor(sample_cent)

# Export to csv
cor_monf <- cor(sample_monf)
write.csv2(cor_monf, file = "cor_monforte.csv", row.names = TRUE)

cor_north <- cor(sample_north)
write.csv2(cor_north, file = "cor_north.csv", row.names = TRUE)

cor_cent <- cor(sample_cent)
write.csv2(cor_cent, file = "cor_cent.csv", row.names = TRUE)

# Check correlations as scatterplots, distributions and correlation coefficient.
ggpairs(sample_monf)
ggpairs(sample_north)
ggpairs(sample_cent)

# Visualization
ggcorr(sample_monf, method=c("everything", "pearson"))
ggcorr(sample_north, method=c("everything", "pearson"))
ggcorr(sample_cent, method=c("everything", "pearson"))



# Resampling analysis

# Northern area

## set your working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/shp")

## add the sites
sitesSubN <- sf::st_read("sites_northern.shp")

# add the study area
area_northern  <- sf::st_read("area_northern.shp")

# set a window for each area
window_north <- spatstat.geom::as.owin(sf::st_geometry(area_northern))

# create a ppp object
coords_points  <- sf::st_coordinates(sitesSubN)
sitesSubN.ppp  <- ppp(x = sitesSubN$utmx, y = sitesSubN$utmy, window = window_north)

## set the working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/grids")

## Import variables and set the same extent for everyone

ALTA_northern <- terra::rast("ALTA_northern.tif")

TPI100_northern <- raster("TPI100_northern.asc")

TPI500_northern <- raster("TPI500_northern.asc")

TPI1000_northern <- raster("TPI1000_northern.asc")

SLO_northern <- raster("SLO_northern.tif") 

ASP_northern <- raster("ASP_northern.tif") 

HYDROE_northern <- raster("HYDROE_northern.tif")

HYDROC_northern <- raster("HYDROC_northern.tif") 

WET_northern <- raster("WET_northern.tif") 

GEOLE_northern <- raster("GEOLE_northern.tif")

GEOLC_northern <- raster("GEOLC_northern.tif")

VISPR_northern <- raster("VISPR_northern.tif")

LCPC_northern <- raster("LCPC_northern.tif")

TOTINS_northern <- raster("TOTINS_northern.asc") 

DIRINS_northern <- raster("DIRINS_northern.asc") 

DIFINS_northern <- raster("DIFINS_northern.asc")  

WIND_northern <- raster("WIND_northern.asc") 

CPFPCGc_northern <- raster("CPFPCGc_northern.tif")

CPFPCDc_northern <- raster("CPFPCDc_northern.tif")


## ALTA

### Create kernel density plot graph for the variable ALTA.


## Extract cell site from the Northern area
sites_northern_spdf <- SpatialPointsDataFrame(sites_northern, data.frame(sites_northern))


sites_northern$`ALTA (m)` <-  
  raster::extract(ALTA_northern, 
                  sites_northern_spdf)

raster_values <- terra::extract(ALTA_northern, spatstat.geom::coords(sitesSubN.ppp))
sitesSubN$`ALTA (m)` <- raster_values[, 2]

## Delete the grey theme
theme_set(theme_bw())


## Calculate the sites densities for Central area
sites_northern_densities <- sitesSubN %$%
  ALTA_northern %>%
  density(from = 450, to = 766, n = 34) %>%
  broom::tidy() %>%
  tibble::as_tibble() %>%
  dplyr::mutate(y = y * 34) %>%
  dplyr::rename(ALTA = x,
                Frequency = y)

## Calculate possible densities across the study area using resampling
background_ALTA_values <- ALTA_northern %>%
  values() %>%
  na.omit() # Drop all masked (NA) locations

# Draw 999 random samples, and calculate their densities
background_ALTA_densities <- foreach::foreach(n = 1:999, .combine = rbind) %do% {
  background_ALTA_values %>%
    sample(nrow(sitesSubN),
           replace = FALSE) %>%
    density(from = 53, to = 1054, n = 34) %>%
    broom::tidy() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(y = y * 34)
} %>%
  dplyr::group_by(x) %>%
  purrrlyr::by_slice(function(x){
    quantile(x$y, probs = c(0.025, 0.5, 0.975)) %>%
      t() %>%
      broom::tidy()
  }, .collate = "cols") %>%
  magrittr::set_names(c("ALTA", "Lower CI", "Frequency", "Upper CI"))

# Plot distributions
ggplot() +
  geom_line(data = background_ALTA_densities,
            mapping = aes(x = ALTA,
                          y = Frequency)) +
  geom_ribbon(data = background_ALTA_densities,
              mapping = aes(x = ALTA,
                            ymin = `Lower CI`,
                            ymax = `Upper CI`),
              alpha = 0.3) +
  geom_line(data = sites_northern_densities,
            mapping = aes(x = ALTA ,
                          y = Frequency),
            color = "red") +ggtitle("a. ALTA in Northern Mountain ranges")

# Export the figure
png(file = "~/output/FigureALTA-Northern.png",width = 1000,height = 437)
dev.off()


# Draw 999 random samples from background, and compute two-sample Wilcoxon tests (Mann-Whitney U tests)
background_altitude_MWU <- foreach(n = 1:999, .combine = rbind) %do% {
  background_sample <- background_ALTA_values %>%
    sample(nrow(sites_northern),
           replace = FALSE) %>%
    wilcox.test(x = sites_northern$`ALTA (m)`,
                y = .,
                alternative = "greater",
                exact = FALSE) %>%
    broom::tidy() %>%
    tibble::as_tibble()
  
} %>%
  dplyr::select(statistic, p.value)


# Get the median test statistic and 95% confidence interval
background_altitude_MWU <- foreach::foreach(prob = c(0.025,0.5,0.975), .combine = rbind) %do% {
  background_altitude_MWU %>%
    dplyr::summarise_all(quantile, probs = prob)
} %>%
  t() %>%
  magrittr::set_colnames(c("Lower CI","Median","Upper CI")) %>%
  magrittr::set_rownames(c("U statistic","p-value"))



round(background_altitude_MWU, 3)


# Mann–Whitney U test - Northern area

## add rasters
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/grids")

## Import variables and set the same extent for everyone
ALTA_northern    <- rast("ALTA_northern.tif")
TPI100_northern  <- rast("TPI100_northern.asc")
TPI500_northern  <- rast("TPI500_northern.asc")
TPI1000_northern <- rast("TPI1000_northern.asc")
SLO_northern     <- rast("SLO_northern.tif")
ASP_northern     <- rast("ASP_northern.tif")
HYDROE_northern  <- rast("HYDROE_northern.tif")
HYDROC_northern  <- rast("HYDROC_northern.tif")
WET_northern     <- rast("WET_northern.tif")
GEOLE_northern   <- rast("GEOLE_northern.tif")
GEOLC_northern   <- rast("GEOLC_northern.tif")
VISPR_northern   <- rast("VISPR_northern.tif")
LCPC_northern    <- rast("LCPC_northern.tif")
TOTINS_northern  <- rast("TOTINS_northern.asc")
DIRINS_northern  <- rast("DIRINS_northern.asc")
DIFINS_northern  <- rast("DIFINS_northern.asc")
WIND_northern    <- rast("WIND_northern.asc")
CPFPCGc_northern <- rast("CPFPCGc_northern.tif")
CPFPCDc_northern <- rast("CPFPCDc_northern.tif")

## Raster list
rasters_north <- list(
  ALTA      = terra::rast("ALTA_northern.tif"),
  TPI100    = terra::rast("TPI100_northern.asc"),
  TPI500    = terra::rast("TPI500_northern.asc"),
  TPI1000   = terra::rast("TPI1000_northern.asc"),
  SLO       = terra::rast("SLO_northern.tif"),
  ASP       = terra::rast("ASP_northern.tif"),
  HYDROE    = terra::rast("HYDROE_northern.tif"),
  HYDROC    = terra::rast("HYDROC_northern.tif"),
  WET       = terra::rast("WET_northern.tif"),
  GEOLE     = terra::rast("GEOLE_northern.tif"),
  GEOLC     = terra::rast("GEOLC_northern.tif"),
  VISPR     = terra::rast("VISPR_northern.tif"),
  LCPC      = terra::rast("LCPC_northern.tif"),
  TOTINS    = terra::rast("TOTINS_northern.asc"),
  DIRINS    = terra::rast("DIRINS_northern.asc"),
  DIFINS    = terra::rast("DIFINS_northern.asc"),
  WIND      = terra::rast("WIND_northern.asc"),
  CPFPCGc   = terra::rast("CPFPCGc_northern.tif"),
  CPFPCDc   = terra::rast("CPFPCDc_northern.tif")
)
  
# Exact names of the objects in the environment
variables_north <- c("ALTA_northern", "TPI100_northern", "TPI500_northern", "TPI1000_northern",
                     "SLO_northern", "ASP_northern", "HYDROE_northern", "HYDROC_northern",
                     "WET_northern", "GEOLE_northern", "GEOLC_northern", "VISPR_northern",
                     "LCPC_northern", "TOTINS_northern", "DIRINS_northern", "DIFINS_northern",
                     "WIND_northern", "CPFPCGc_northern", "CPFPCDc_northern")

# Create the list with those objects
rasters_north <- mget(variables_north)

# Rename so that the output table is clean (without "_northern")
names(rasters_north) <- gsub("_northern$", "", variables_north)


# set your working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/shp")

# add the study area and sites
area_north_vect  <- terra::vect("area_northern.shp")
sites_north_vect <- terra::vect("sites_northern.shp")

area_north_vect  <- terra::project(area_north_vect,  "EPSG:25829")
sites_north_vect <- terra::project(sites_north_vect, "EPSG:25829")


## Function

run_mwu <- function(r, sites_vect, area_vect, n_iter = 999) {
  

# Force areas and sites to have the exact CRS of the raster
crs_r        <- terra::crs(r)
area_vect    <- terra::project(area_vect,  crs_r)
sites_vect   <- terra::project(sites_vect, crs_r)
  
# Clip and mask the raster to the study area
r_mask <- terra::mask(terra::crop(r, area_vect), area_vect)
  
# Background values within the area
background_values <- terra::values(r_mask, mat = FALSE, na.rm = TRUE)
  
# Raster values at the sites
site_values <- terra::extract(r, sites_vect, ID = FALSE, na.rm = TRUE)[, 1]
site_values <- site_values[!is.na(site_values)]
  
n_sites <- length(site_values)
  
# n_iter tests Mann-Whitney U
mwu_results <- foreach(n = 1:n_iter, .combine = rbind) %do% {
  background_sample <- sample(background_values, n_sites, replace = FALSE)
    
  wilcox.test(x = site_values,
              y = background_sample,
              alternative = "greater",
              exact = FALSE) %>%
    broom::tidy() %>%
    tibble::as_tibble()
} %>%
  dplyr::select(statistic, p.value)
  
# Median and IC 95%
summary_res <- foreach::foreach(prob = c(0.025, 0.5, 0.975), .combine = rbind) %do% {
  mwu_results %>%
    dplyr::summarise_all(quantile, probs = prob)
} %>%
  t() %>%
  magrittr::set_colnames(c("Lower CI", "Median", "Upper CI")) %>%
  magrittr::set_rownames(c("U statistic", "p-value"))
  
  return(summary_res)
}

set.seed(123)   

results_northern <- analyse_area(
  rasters_area = rasters_north,        # 19 rasters list
  sites_vect   = sites_north_vect,     # sites SpatVector 
  area_vect    = area_north_vect,      # area SpatVector 
  area_name    = "Northern",
  output_file  = "C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/outputs/MWU_Northern.xlsx",
  n_iter       = 999
)

print(results_northern)



# Mann–Whitney U test - Central area

## add rasters
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/grids")

## Import variables and set the same extent for everyone
ALTA_central    <- rast("ALTA_central.tif")
TPI100_central  <- rast("TPI100_central.asc")
TPI500_central  <- rast("TPI500_central.asc")
TPI1000_central <- rast("TPI1000_central.asc")
SLO_central     <- rast("SLO_central.tif")
ASP_central     <- rast("ASP_central.tif")
HYDROE_central  <- rast("HYDROE_central.tif")
HYDROC_central  <- rast("HYDROC_central.tif")
WET_central     <- rast("WET_central.tif")
GEOLE_central   <- rast("GEOLE_central.tif")
GEOLC_central   <- rast("GEOLC_central.tif")
VISPR_central   <- rast("VISPR_central.tif")
LCPC_central    <- rast("LCPC_central.tif")
TOTINS_central  <- rast("TOTINS_central.asc")
DIRINS_central  <- rast("DIRINS_central.asc")
DIFINS_central  <- rast("DIFINS_central.asc")
WIND_central    <- rast("WIND_central.asc")
CPFPCGc_central <- rast("CPFPCGc_central.tif")
CPFPCDc_central <- rast("CPFPCDc_central.tif")

## Raster list
rasters_north <- list(
  ALTA      = terra::rast("ALTA_central.tif"),
  TPI100    = terra::rast("TPI100_central.asc"),
  TPI500    = terra::rast("TPI500_central.asc"),
  TPI1000   = terra::rast("TPI1000_central.asc"),
  SLO       = terra::rast("SLO_central.tif"),
  ASP       = terra::rast("ASP_central.tif"),
  HYDROE    = terra::rast("HYDROE_central.tif"),
  HYDROC    = terra::rast("HYDROC_central.tif"),
  WET       = terra::rast("WET_central.tif"),
  GEOLE     = terra::rast("GEOLE_central.tif"),
  GEOLC     = terra::rast("GEOLC_central.tif"),
  VISPR     = terra::rast("VISPR_central.tif"),
  LCPC      = terra::rast("LCPC_central.tif"),
  TOTINS    = terra::rast("TOTINS_central.asc"),
  DIRINS    = terra::rast("DIRINS_central.asc"),
  DIFINS    = terra::rast("DIFINS_central.asc"),
  WIND      = terra::rast("WIND_central.asc"),
  CPFPCGc   = terra::rast("CPFPCGc_central.tif"),
  CPFPCDc   = terra::rast("CPFPCDc_central.tif")
)

# Exact names of the objects in the environment
variables_central <- c("ALTA_central", "TPI100_central", "TPI500_central", "TPI1000_central",
                     "SLO_central", "ASP_central", "HYDROE_central", "HYDROC_central",
                     "WET_central", "GEOLE_central", "GEOLC_central", "VISPR_central",
                     "LCPC_central", "TOTINS_central", "DIRINS_central", "DIFINS_central",
                     "WIND_central", "CPFPCGc_central", "CPFPCDc_central")

# Create the list with those objects
rasters_central <- mget(variables_central)

# Rename so that the output table is clean (without "_central")
names(rasters_central) <- gsub("_central$", "", variables_central)


# set your working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/shp")

# add the study area and sites
area_central_vect  <- terra::vect("area_central.shp")
sites_central_vect <- terra::vect("sites_central.shp")

area_central_vect  <- terra::project(area_central_vect,  "EPSG:25829")
sites_central_vect <- terra::project(sites_central_vect, "EPSG:25829")


## Function

run_mwu <- function(r, sites_vect, area_vect, n_iter = 999) {
  
  
  # Force areas and sites to have the exact CRS of the raster
  crs_r        <- terra::crs(r)
  area_vect    <- terra::project(area_vect,  crs_r)
  sites_vect   <- terra::project(sites_vect, crs_r)
  
  # Clip and mask the raster to the study area
  r_mask <- terra::mask(terra::crop(r, area_vect), area_vect)
  
  # Background values within the area
  background_values <- terra::values(r_mask, mat = FALSE, na.rm = TRUE)
  
  # Raster values at the sites
  site_values <- terra::extract(r, sites_vect, ID = FALSE, na.rm = TRUE)[, 1]
  site_values <- site_values[!is.na(site_values)]
  
  n_sites <- length(site_values)
  
  # n_iter tests Mann-Whitney U
  mwu_results <- foreach(n = 1:n_iter, .combine = rbind) %do% {
    background_sample <- sample(background_values, n_sites, replace = FALSE)
    
    wilcox.test(x = site_values,
                y = background_sample,
                alternative = "greater",
                exact = FALSE) %>%
      broom::tidy() %>%
      tibble::as_tibble()
  } %>%
    dplyr::select(statistic, p.value)
  
  # Median and IC 95%
  summary_res <- foreach::foreach(prob = c(0.025, 0.5, 0.975), .combine = rbind) %do% {
    mwu_results %>%
      dplyr::summarise_all(quantile, probs = prob)
  } %>%
    t() %>%
    magrittr::set_colnames(c("Lower CI", "Median", "Upper CI")) %>%
    magrittr::set_rownames(c("U statistic", "p-value"))
  
  return(summary_res)
}

set.seed(123)   

results_northern <- analyse_area(
  rasters_area = rasters_central,        # 19 rasters list
  sites_vect   = sites_central_vect,     # sites SpatVector 
  area_vect    = area_central_vect,      # area SpatVector 
  area_name    = "central",
  output_file  = "C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/outputs/MWU_Central.xlsx",
  n_iter       = 999
)

print(results_northern)




# Mann–Whitney U test - Monforte area

## add rasters
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/grids")

## Import variables and set the same extent for everyone
ALTA_monforte    <- rast("ALTA_monforte.tif")
TPI100_monforte  <- rast("TPI100_monforte.asc")
TPI500_monforte  <- rast("TPI500_monforte.asc")
TPI1000_monforte <- rast("TPI1000_monforte.asc")
SLO_monforte     <- rast("SLO_monforte.tif")
ASP_monforte     <- rast("ASP_monforte.tif")
HYDROE_monforte  <- rast("HYDROE_monforte.tif")
HYDROC_monforte  <- rast("HYDROC_monforte.tiff")
WET_monforte     <- rast("WET_monforte.tiff")
GEOLE_monforte   <- rast("GEOLE_monforte.tif")
GEOLC_monforte   <- rast("GEOLC_monforte.tiff")
VISPR_monforte   <- rast("VISPR_monforte.tif")
LCPC_monforte    <- rast("LCPC_monforte.tiff")
TOTINS_monforte  <- rast("TOTINS_monforte.asc")
DIRINS_monforte  <- rast("DIRINS_monforte.asc")
DIFINS_monforte  <- rast("DIFINS_monforte.asc")
WIND_monforte    <- rast("WIND_monforte.asc")
CPFPCGc_monforte <- rast("CPFPCGc_monforte.tif")
CPFPCDc_monforte <- rast("CPFPCDc_monforte.tif")

## Raster list
rasters_north <- list(
  ALTA      = terra::rast("ALTA_monforte.tif"),
  TPI100    = terra::rast("TPI100_monforte.asc"),
  TPI500    = terra::rast("TPI500_monforte.asc"),
  TPI1000   = terra::rast("TPI1000_monforte.asc"),
  SLO       = terra::rast("SLO_monforte.tif"),
  ASP       = terra::rast("ASP_monforte.tif"),
  HYDROE    = terra::rast("HYDROE_monforte.tif"),
  HYDROC    = terra::rast("HYDROC_monforte.tiff"),
  WET       = terra::rast("WET_monforte.tiff"),
  GEOLE     = terra::rast("GEOLE_monforte.tif"),
  GEOLC     = terra::rast("GEOLC_monforte.tiff"),
  VISPR     = terra::rast("VISPR_monforte.tif"),
  LCPC      = terra::rast("LCPC_monforte.tiff"),
  TOTINS    = terra::rast("TOTINS_monforte.asc"),
  DIRINS    = terra::rast("DIRINS_monforte.asc"),
  DIFINS    = terra::rast("DIFINS_monforte.asc"),
  WIND      = terra::rast("WIND_monforte.asc"),
  CPFPCGc   = terra::rast("CPFPCGc_monforte.tif"),
  CPFPCDc   = terra::rast("CPFPCDc_monforte.tif")
)

# Exact names of the objects in the environment
variables_monforte <- c("ALTA_monforte", "TPI100_monforte", "TPI500_monforte", "TPI1000_monforte",
                       "SLO_monforte", "ASP_monforte", "HYDROE_monforte", "HYDROC_monforte",
                       "WET_monforte", "GEOLE_monforte", "GEOLC_monforte", "VISPR_monforte",
                       "LCPC_monforte", "TOTINS_monforte", "DIRINS_monforte", "DIFINS_monforte",
                       "WIND_monforte", "CPFPCGc_monforte", "CPFPCDc_monforte")

# Create the list with those objects
rasters_monforte <- mget(variables_monforte)

# Rename so that the output table is clean (without "_central")
names(rasters_monforte) <- gsub("_monforte$", "", variables_monforte)


# set your working directory
setwd("C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/shp")

# add the study area and sites
area_monforte_vect  <- terra::vect("area_monforte.shp")
sites_monforte_vect <- terra::vect("sites_monforte.shp")

area_monforte_vect  <- terra::project(area_monforte_vect,  "EPSG:25829")
sites_monforte_vect <- terra::project(sites_monforte_vect, "EPSG:25829")


## Function

run_mwu <- function(r, sites_vect, area_vect, n_iter = 999) {
  
  
  # Force areas and sites to have the exact CRS of the raster
  crs_r        <- terra::crs(r)
  area_vect    <- terra::project(area_vect,  crs_r)
  sites_vect   <- terra::project(sites_vect, crs_r)
  
  # Clip and mask the raster to the study area
  r_mask <- terra::mask(terra::crop(r, area_vect), area_vect)
  
  # Background values within the area
  background_values <- terra::values(r_mask, mat = FALSE, na.rm = TRUE)
  
  # Raster values at the sites
  site_values <- terra::extract(r, sites_vect, ID = FALSE, na.rm = TRUE)[, 1]
  site_values <- site_values[!is.na(site_values)]
  
  n_sites <- length(site_values)
  
  # n_iter tests Mann-Whitney U
  mwu_results <- foreach(n = 1:n_iter, .combine = rbind) %do% {
    background_sample <- sample(background_values, n_sites, replace = FALSE)
    
    wilcox.test(x = site_values,
                y = background_sample,
                alternative = "greater",
                exact = FALSE) %>%
      broom::tidy() %>%
      tibble::as_tibble()
  } %>%
    dplyr::select(statistic, p.value)
  
  # Median and IC 95%
  summary_res <- foreach::foreach(prob = c(0.025, 0.5, 0.975), .combine = rbind) %do% {
    mwu_results %>%
      dplyr::summarise_all(quantile, probs = prob)
  } %>%
    t() %>%
    magrittr::set_colnames(c("Lower CI", "Median", "Upper CI")) %>%
    magrittr::set_rownames(c("U statistic", "p-value"))
  
  return(summary_res)
}

set.seed(123)   

results_monforte <- analyse_area(
  rasters_area = rasters_monforte,        # 19 rasters list
  sites_vect   = sites_monforte_vect,     # sites SpatVector 
  area_vect    = area_monforte_vect,      # area SpatVector 
  area_name    = "monforte",
  output_file  = "C:/Users/Mikel/Documents/Curso_2023-2024/Paper_AAS/Github/spatial_patterns/spatial_patterns/outputs/MWU_Monforte.xlsx",
  n_iter       = 999
)

print(results_northern)