# It has been 2+ years that the Covid-19 pandemic has put our life and behaviors in check. This project uses the Covid-19 dataset maintained.For starting the virus is "peculiar" as not all the infected individuals 
# experience the same symptoms. Some individuals display symptoms that are similar to the ones of a common cold or flu while other individuals experience serious symptoms that can cause death or hospitalization with  different 
# levels of severity, including staying in intensive-care units (ICU) for several weeks or even months.Elderly are the most vulnerable to the disease and reported mortality rates vary from 5 to 15% depending on the geographical 
# location.

# Here we will introduce and discuss the covid19.analytics R package.which is mainly designed and focus in an open and modular approach to provide researchers quick access to the latest reported worldwide data of the CoViD19 
# cases, as well as, analytically and visualization tools to process this data.


# installing 'covid19.analytics' from CRAN
install.packages("covid19.analytics")

###

# install 'covid19.analytics' from GITHUB
# need devtools for installing from the github repo
install.packages("devtools")

# install 'covid19.analytics'
devtools::install_github("mponce0/covid19.analytics")


install.packages("webshot")

webshot::install_phantomjs()

######

# obtain all the records combined for "confirmed", "deaths" and "recovered" cases
# for the global (worldwide) *aggregated* data
covid19.data.ALLcases <- covid19.data()

# obtain time series data for global "confirmed" cases
covid19.confirmed.cases <- covid19.data("ts-confirmed")

# reads all possible datasets, returning a list
covid19.all.datasets <- covid19.data("ALL")

# reads the latest aggregated data of the global cases
covid19.ALL.agg.cases <- covid19.data("aggregated")

# reads time series data for global casualties
covid19.TS.deaths <- covid19.data("ts-deaths")

# read "Time Series" data for the city of Toronto
Toronto.TS.data <- covid19.data("ts-Toronto")

# this can be also done using the covid19.Toronto.data() fn
Tor.TS.data <- covid19.Toronto.data() 

# or get the original data as reported by the City of Toronto
Tor.DF.data <- covid19.Toronto.data(data.fmt="ORIG")

# retrieve US time series data of confirmed cases
US.confirmed.cases <- covid19.data("ts-confirmed-US")

# retrieve US time series data of death cases
US.deaths.cases <- covid19.data("ts-deaths-US")

# or both cases combined
US.cases <- covid19.US.data()


# obtain covid19's genomic data
covid19.gen.seq <- covid19.genomic.data()

# display the actual RNA seq
covid19.gen.seq$NC_045512.2

# a quick function to overview top cases per region for time series and aggregated records
report.summary()

# summary report for location U.S with top 5
report.summary(Nentries=5, geo.loc="US")

# save the tables into a text file named 'covid19-SummaryReport_CURRENTDATE.txt'
# where *CURRRENTDATE* is the actual date
report.summary(saveReport=TRUE)

# summary report for an specific location with default number of entries
report.summary(geo.loc="Canada")


# it can combine several locations
report.summary(Nentries=30, geo.loc=c("Canada","US","Italy","Uruguay","Argentina"))



# read time series data for confirmed cases
TS.data <- covid19.data("ts-confirmed")

# compute changes and growth rates per location for all the countries
growth.rate(TS.data)

# compute changes and growth rates per location for 'Italy'
growth.rate(TS.data,geo.loc="Italy")

# compute changes and growth rates per location for 'Italy' and 'Germany'
growth.rate(TS.data,geo.loc=c("Italy","Germany"))

# Combining multiple geographical locations:

# obtain Time Series data
TSconfirmed <- covid19.data("ts-confirmed")


# explore different combinations of regions/cities/countries

# when combining different locations, heatmaps will also be generated comparing the trends among these locations
growth.rate(TSconfirmed,geo.loc=c("Italy","Canada","Ontario","Quebec","Uruguay"))

growth.rate(TSconfirmed,geo.loc=c("Hubei","Italy","Spain","United States","Canada","Ontario","Quebec","Uruguay"))

growth.rate(TSconfirmed,geo.loc=c("Hubei","Italy","Spain","US","Canada","Ontario","Quebec","Uruguay"))

# turn off static plots and activate interactive figures
growth.rate(TSconfirmed,geo.loc=c("Brazil","Canada","Ontario","US"), staticPlt=FALSE, interactiveFig=TRUE)

# static and interactive figures
growth.rate(TSconfirmed,geo.loc=c("Brazil","Italy","India","US"), staticPlt=TRUE, interactiveFig=TRUE)


# single location trend, in this case using data from the City of Toronto
tor.data <- covid19.Toronto.data()
single.trend(tor.data[tor.data$status=="Active Cases",])


# read time series data for confirmed cases

TS.data <- covid19.data("ts-ALL")

TS.data <- covid19.data("ts-confirmed")

ts.data <- covid19.data("ts-confirmed")

# Data for U.S.
single.trend(ts.data[ ts.data$Country.Region=="US",])

# compute changes and growth rates per location for 'US' and 'UK'
growth.rate(TS.data,geo.loc=c("US","United Kingdom"))


# interactive plot of trends
# for U.S. location and all type of cases
itrends(covid19.data("ts-ALL"),geo.loc="US")

itrends(covid19.data("ts-confirmed"), geo.loc=c("United Kingdom","US","Italy"), fileName="itrends_ex")


# multiple locations
ts.data <- covid19.data("ts-confirmed")
mtrends(ts.data, geo.loc=c("Canada","Ontario","Uruguay","Italy"))

# multiple cases
mtrends(tor.data)


# retrieve time series data
TS.data <- covid19.data("ts-ALL")

# static and interactive plot 
totals.plt(TS.data)
# totals for Ontario and Canada, without displaying totals and one plot per page
totals.plt(TS.data, c("Canada","Ontario"), with.totals=FALSE,one.plt.per.page=TRUE)

# totals for Ontario, Canada, Italy and Uruguay; including global totals with the linear and semi-log plots arranged one next to the other
totals.plt(TS.data, c("Canada","Ontario","Italy","Uruguay"), with.totals=TRUE,one.plt.per.page=FALSE)

# totals for all the locations reported on the dataset, interactive plot will be saved as "totals-all.html"
totals.plt(TS.data, "ALL", fileName="totals-all")
# retrieve aggregated data
data <- covid19.data("aggregated")

# interactive map of aggregated cases -- with more spatial resolution
live.map(data)

# or
live.map()

# interactive map of the time series data of the confirmed cases with less spatial resolution, ie. aggregated by country
live.map(covid19.data("ts-confirmed"))


# read time series data for confirmed cases
data <- covid19.data("ts-confirmed")


# run a SIR model for a given geographical location
generate.SIR.model(data,"US")
generate.SIR.model(data,"Uruguay", tot.population=3500000)
generate.SIR.model(data,"Ontario",tot.population=14570000)

# run a SIR model for a given geographical location
generate.SIR.model(data,"US", t0=1,t1=15)


# modelling the spread for the whole world, storing the model and generating an interactive visualization
world.SIR.model <- generate.SIR.model(data,"ALL", t0=1,t1=15, tot.population=7.8e9, staticPlt=FALSE)

# plotting and visualizing the model
plt.SIR.model(world.SIR.model,"World",interactiveFig=TRUE,fileName="world.SIR.model", add.extras=TRUE)


# read TimeSeries data
TS.data <- covid19.data("TS-confirmed")

# select a location of interest, eg. US
US.data <- TS.data[ (TS.data$Country.Region == "US") & (TS.data$Province.State == ""),]

# sweep values of R0 based on range of dates to consider for the model
ranges <- 15:25
deltaT <- 35
params_sweep <- sweep.SIR.models(data=US.data,geo.loc="US", t0_range=ranges, deltaT=deltaT)

# the parameters --beta,gamma,R0-- are returned in a "matrix" "array" object
print(params_sweep)
#       [,1]      [,2]      [,3]      [,4]      [,5]      [,6]      [,7]    
# beta  0.5231031 0.5250777 0.5323438 0.5217565 0.5355503 0.5473388 0.559132
# gamma 0.4768969 0.4749223 0.4676562 0.4782435 0.4644497 0.4526611 0.440868
# R0    1.096889  1.105608  1.138323  1.090985  1.153086  1.209158  1.268253
#       [,8]      [,9]      [,10]     [,11]   
# beta  0.5668948 0.5753911 0.5835743 0.592407
# gamma 0.4331052 0.4246089 0.4164257 0.407593
# R0    1.308908  1.355108  1.401389  1.453428

# obtain the R0 values from the parameters
R0s <- unlist(params_sweep["R0",])
# nbr of infected cases
US.infs<- preProcessingData(US.data,"US")

# average per range
# define ranges
lst.ranges <- lapply(ranges, function(x) x:(x+deltaT))

# compute averages
avg.US.infs <- lapply(lst.ranges, function(x) mean(US.infs[x]))

# plots
plot(R0s, type='b')
# plot vs average number of infected cases
plot(avg.US.infs, R0s, type='b')
