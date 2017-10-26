
#' Write a Dataframe to a file as seperated values
#'
#' Checks for existence of file and directory specified. If either don't exist,
#' they are created.
#' @author Ian C Johnson
#'
#' @param df dataframe to be written
#' @param fname string name of the file name including file extension. If it
#'   doesn't exist, it will be created.
#' @param fpath the path of the save location. If it doesn't exist, it will be
#'   created.
#' @param delim the string character to seperate the values in the new file.
#'   Default = ","
#'
#' @return NULL
#' @export
#'
#' @examples
#' WriteToFile(df = myDataFrame, fname = "myFileName.csv", fpath = "./path from home dir/", delim = ",")

WriteToFile <- function(df, fname, fpath, delim, addAsNewSht) {
  require(openxlsx)
  require(readr)
  require(stringr)

  #determine the type of file to be written
  ftype <- GetFileType(fname)

  #create the total file path for existence checks
  full_path <- str_c(fpath, fname)

  if (CheckForDirNotExist(fpath)) {
    dir.create(fpath)
  }
  ftype <- GetFileType(fname)
  if (CheckForFileNotExist(full_path)) {
    if (!ftype == "excel") {
      file.create(full_path)
    }
  }




  #add logic to handle various file types here
  if (ftype == "csv") {
    if (missing(delim)) {delim <- ", "}
    write_delim(df, path = full_path, append = FALSE, delim = delim)
  } else if (ftype == "excel") {
    #
    # placeholder for a headerstyle and table styles
    #
    if(missing(addAsNewSht)) {addAsNewSht <- T}
    write.xlsx(df, file = full_path,
               creator = Sys.getenv("USERNAME"),
               startCol = 1, startRow = 2,
               colNames = TRUE, keepNA = TRUE,
               firstActiveRow = 3, colWidths = "auto",
               overwrite = TRUE)
  }
}

#' Load Data From a File
#'
#' @description Load a dataframe from a given excel or csv file with a simpler call than readxl or read.csv alternatives
#' @usage LoadFromFile(fname, fpath, skip, delim = ",")
#'
#' @param fname the name of the file to be loaded including it's file type suffix
#' @param fpath the path of the file
#' @param skip the number of rows to skip before reading data
#' @param delim the deliminator if the input file is a csv type
#'
#' @return dataframe containing the file's data with column names
#' @export
#'
#' @examples
LoadFromFile <- function(fname, fpath, skip, sht, delim) {
  require(stringr)
  #stop if the file or directory does not exist.
  full_path <- str_c(fpath, fname)
  stopifnot(CheckForDirNotExist("fpath"), CheckForFileNotExist("full_path"))

  if(!require(readxl)) {
    install.packages(readxl)
  }

  #get the file type from the file extension (those letters after the final . in the )
  ftype <- GetFileType(fname)

  #setup various file type handlers here
  if (ftype == "excel") {
    new_df <- read_excel(path = fpath, sheet = 1, col_names = TRUE, skip = skip)
  } else if (ftype == "csv") {
    new_df <- read.csv(file = fpath, header = TRUE, sep = delim)
  }
  return(new_df)
}

#' Determine a given file's type
#' @description determine a file's type by it's file extension. Common file types include excel -- .xls, .xlsx, .xlsm and csv -- .csv or .txt
#' @param fname the name or extension of the file
#'
#' @return a string description of the file type i.e. "excel" or "csv"
#' @export
#'
#' @examples
GetFileType <- function(fname) {
  #check everything after the period
  ftypestr <- sub(pattern = ".*\\.", replacement = "", x = fname)

  #check it against the list of file names to extensions
  ftypemaster <- c("xlsx" = "excel", "xlsm" = "excel", "txt" = "csv", "csv" = "csv")
  type <- ftypemaster[ftypestr]
  return(type)
}

CheckForFileNotExist <- function(full_path) {
  doesNotExist <- !file.exists(full_path)
  return(doesNotExist)
}

CheckForDirNotExist <- function(fpath) {
  doesNotExist <- !dir.exists(fpath)
  return(doesNotExist)
}



