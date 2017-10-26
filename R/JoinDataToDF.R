#' Left Join data from one dataframe to another
#'
#' @description Take two dataframes and specify the column names to be used to
#'   match keys. The 2nd specified dataframe will be left joined to the 1st
#'   specified dataframe. This function is a basic wrapper for dplyr's
#'   left_join.
#'
#' @param df the dataframe to which columns will be appended
#' @param df_lu the dataframe containing values to be added to original
#'   dataframe
#' @param key_main the column name of the key in the primary dataframe
#' @param key_lu the column name of the key in the lookup dataframe.
#'
#' @return the original dataframe df with additional columns joined from df_lu
#' @export
#'
#' @examples
JoinDataToDF <- function(df, df_lu, key_main, key_lu)  {
  require(dplyr)
  #save the original column names that will be swapped out with the constant "Key"
  temp_field_name_main <- key_main
  temp_field_name_lu <- key_lu

  #Key_Unique_To_Program_232323 should be unique, but if it's not.... fuck it, i'll come back and figure
  # something else out
  df <- RenameColumn(df, old_name = key_main, new_name = "Key_Unique_To_Program_232323")
  df_lu <- RenameColumn(df_lu, old_name = key_lu, new_name = "Key_Unique_To_Program_232323")

  df <- left_join(df, df_lu, by = c("Key_Unique_To_Program_232323" = "Key_Unique_To_Program_232323"))

  #put back the original colnames
  df <- RenameColumn(df, old_name = "Key_Unique_To_Program_232323", new_name = key_main)
  df_lu <- RenameColumn(df_lu, old_name = "Key_Unique_To_Program_232323", new_name = key_lu)
  return(df)
}
