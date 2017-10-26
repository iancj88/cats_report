#' Rename a column
#'
#' @param df the dataframe containing the column to be renamed
#' @param old_name the column name of the column to be renamed
#' @param new_name the new column name to be used in the replacement
#'
#' @return the input dataframe with the specified column renamed
#' @export
#'
#' @examples
RenameColumn <- function(df, old_name, new_name) {
  colnames(df)[which(names(df) == old_name)] <- new_name
  return(df)
}

