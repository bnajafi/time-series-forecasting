to.POSIXct <- function(year, monthNumber){
  ## Function to create a POSIXct time series 
  ## object from a year.month format
  
  ## Create a character vector from the numeric input
  dateStr <- paste(as.character(year), "-",
                   as.character(monthNumber), "-",
                   "01", sep = "")
  ## Return the POSIXct time series object
  as.POSIXct( strptime(dateStr, "%Y-%m-%d"))
}

order.month <- function(x){
  ## Function to make Month column an ordered factor.
  x <- substr(x, 1, 3) ## Use just the first three letters
  factor(x, 
         levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
         ordered = TRUE)
}

read.dairy <- function(dataSet = 'cadairydata.csv'){
  ##library("AzureML")
  #ws <- workspace()
  df <- read.csv(dataSet)
  df$dateTime <- to.POSIXct(df$Year, df$Month.Number)
  dropCols <- c("X","Year.Month", "Month.Number")
  df$Month <- order.month(df$Month)
  df[ , !(names(df) %in% dropCols)]
}

dairy <- read.dairy()