# install and load multiple R packages.
# check to see if packages are installed. Install them if they are not, then load them into the R session.

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
# usage
packages <- c("sf", "mapview", "spatstat.geom", "GGally", "ggplot2")
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

# Check correlations as scatterplots, distributions and correlation coefficient.
ggpairs(sample_monf)

# Visualization
ggcorr(sample_monf, method=c("everything", "pearson"))
