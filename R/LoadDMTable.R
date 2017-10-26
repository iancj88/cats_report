# Load underlying table data from the Argos Extract "Datamart Base Table"
# located in the "Central HR" folder. Requires the external "hrutilmsu" package
# to load the file, otherwise include the 'LoadFromFile' function.

load_base_table <- function(file = "./src/base_table_20170920.csv") {
  require(data.table)
  num_cols <- fread(input = file, data.table = FALSE, nrows = 0) %>%
    names() %>%
    length()
  
  colclasses <- rep("c", num_cols)
  
  df <- fread(input = file, data.table = FALSE, colClasses = colclasses)
  return(df)
}

load_jobs_table <- function(file = "./src/jobs_table_20171003.csv") {
  require(data.table)
  num_cols <- fread(input = file, data.table = FALSE, nrows = 0) %>%
    names() %>%
    length()
  
  colclasses <- rep("c", num_cols)
  
  df <- fread(input = file, data.table = FALSE, colClasses = colclasses)
  return(df)
}

fix_col_types <- function(df) {
  df$BASE_LONGEVITY_PERCENT <- as.numeric(df$BASE_LONGEVITY_PERCENT)
  df$BASE_LONGEVITY_YEARS <- as.numeric(df$BASE_LONGEVITY_YEARS)
  df$BASE_YEARS_OF_SERVICE <- as.numeric(df$BASE_YEARS_OF_SERVICE)
  df$JOBS_FTE <- as.numeric(df$JOBS_FTE)
  df$JOBS_REG_RATE <- as.numeric(df$JOBS_REG_RATE)
  df$JOBS_ANNUAL_SALARY <- as.numeric(df$JOBS_ANNUAL_SALARY)
  df$JOBS_ASSGN_SALARY <- as.numeric(df$JOBS_ASSGN_SALARY)
  df$JOBS_LONGEVITY_ANNUAL_SALARY <- as.numeric(df$JOBS_LONGEVITY_ANNUAL_SALARY)
  df$JOBS_LONGEVITY_ASSGN_SALARY <- as.numeric(df$JOBS_LONGEVITY_ASSGN_SALARY)
  df$JOBS_LONGEVITY_HOURLY_RATE <- as.numeric(df$JOBS_LONGEVITY_HOURLY_RATE)
  df$JOBS_TRANSFER_OUT <- as.numeric(df$JOBS_TRANSFER_OUT)
  df$JOBS_FTE_CHANGE <- as.numeric(df$JOBS_FTE_CHANGE)
  df$JOBS_TERMINATION <- as.numeric(df$JOBS_TERMINATION)
  df$JOBS_LWOP_START <- as.numeric(df$JOBS_LWOP_START)
  df$JOBS_LWOP <- as.numeric(df$JOBS_LWOP)
  df$JOBS_LWOP_END <- as.numeric(df$JOBS_LWOP_END)
  df$JOBS_ACTIVE <- as.numeric(df$JOBS_ACTIVE)
  df$JOBS_TRANSFER_IN <- as.numeric(df$JOBS_TRANSFER_IN)
  df$JOBS_NEW_HIRE <- as.numeric(df$JOBS_NEW_HIRE)
  df$JOBS_ANNUALIZED_SALARY <- as.numeric(df$JOBS_ANNUALIZED_SALARY)
  df$JOBS_FTE_CHANGE <- as.numeric(df$JOBS_FTE_CHANGE)
  return(df)
}

