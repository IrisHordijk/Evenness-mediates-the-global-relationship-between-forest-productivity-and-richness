#Test Github

#########Projections
names(Npp_Global)
#dataset = Npp_Global[,-c("H1Stand")]
dataset <- Npp_Global[complete.cases(Npp_Global), ]

DepVar <- dataset[, c("Plot_ID", "WWF_Biome_reduced", "WWFBiome", "S", "Diversity", "H1", "H1Stand", "Simpson", "evar", "ForestReserve","Npp_new", "Npp", "Plotsize")]
IndVar <- dataset[, c("Annual_Mean_Temperature", "Annual_Precipitation", "CContent_15cm", "Isothermality", "Precipitation_Seasonality", "Sand_Content_15cm", "pHinHOX_15cm", "Human_Development_Percentage", "Population_Density", "SecondaryForest", "ForestAge", "TreesPerHa")]
IndVar.scaled <- as.data.frame(scale(IndVar)) #Scale data

scaled <- cbind(IndVar.scaled, dataset$Plot_ID)
setnames(scaled, old = c("dataset$Plot_ID"), new = c("Plot_ID"))
dataset <- merge(scaled, DepVar, by="Plot_ID")

###Model with environmental conditions
dataset$E <- dataset$H1Stand
Model_Productivity_env <- lm(Npp_new ~ S*E + S + E + TreesPerHa + Annual_Mean_Temperature + Isothermality + Annual_Precipitation +
                               Precipitation_Seasonality + Sand_Content_15cm + pHinHOX_15cm + CContent_15cm + Human_Development_Percentage + Population_Density + ForestAge + factor(WWFBiome),
                             data=dataset)  