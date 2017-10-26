
AddOrgHierarchy <- function(df, 
                            lu_file_location, 
                            df_dept_number_name) {
  
  org_lu <- read.csv(file = lu_file_location, header = T)
  
  org_lu$Org <- as.character(org_lu$Org)
  df <- JoinDataToDF(df = df, 
                     df_lu = org_lu, 
                     key_main = df_dept_number_name,
                     key_lu = "Org")
  
  return(df)
}

AddEETypeRollup <- function (df, 
                             df_ecls_field_name,
                             suff_field_name,
                             MUS_field_name) {
  
  ecls <- df_ecls_field_name
  mus <- MUS_field_name
  suff <- suff_field_name
  
  student_rows <- df[,ecls] == "1H"
  graduate_rows <- df[,ecls] %in% c("1D", "1S")
  executive_rows <- df[,ecls] == "EX"
  # TODO: Handle summer session positions. Do those only belong to TT faculty?
  tt_faculty_rows <- df[,ecls] %in% c("FA", "FB", "FF", "FZ")
  ntt_faculty_rows <- df[,ecls] %in% c("FH", "FJ", "FL", "FM", "FN", "FP")
  # TODO: Research the "SY" Ecls to determine if it is classified or professional
  classified_rows <- df[,ecls] %in% c("HF", "HP", "HV", "SE", "SF", "SN", "SP", "SY")
  nonjob_rows <- df[,ecls] %in% c("FE", "MG", "NP", "RE")
  professional_rows <- df[,ecls] %in% c("PF", "PH", "PP", "PS", "PY", "PZ", "HC", "AF", "AP")
  temp_worker_rows <- df[,ecls] %in% c("TH", "TM", "TS")
  
  df[student_rows, "Employee_Rollup"] <- "Student Worker"
  df[graduate_rows, "Employee_Rollup"] <- "Graduate Assistant"
  df[executive_rows, "Employee_Rollup"] <- "Executive"
  df[tt_faculty_rows, "Employee_Rollup"] <- "Faculty TT/T"
  df[ntt_faculty_rows, "Employee_Rollup"] <- "Faculty NTT"
  df[classified_rows, "Employee_Rollup"] <- "Classified"
  df[nonjob_rows, "Employee_Rollup"] <- "Non-Job Payment"
  df[professional_rows, "Employee_Rollup"] <- "Professional"
  df[temp_worker_rows, "Employee_Rollup"] <- "Temporary"
  
  nonjob_suffix_rows <- df[,suff] %in% c("SD", "TF", "CR", "RF", 
                                         "TL", "OT", "OL", "OC", 
                                         "TR", "CT", "LS", "AD", 
                                         "Sd", "TM", "SE", "SF")
  df[nonjob_suffix_rows, "Employee_Rollup"] <- "Non-Job Payment"
  
  return(df)
}

AddFullPartTimeStatus <- function(df, fte_col_name) {
  
  full_time_rows <- as.numeric(df[,fte_col_name]) >= .8
  
  df[full_time_rows, "Full_Part_Time_Status"] <- "Full Time"
  df[!full_time_rows, "Full_Part_Time_Status"] <- "Part Time"
  
  return(df)
}
