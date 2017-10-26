# Load the base 
pacman::p_load(dplyr)

script_files <- c("./R/LoadDMTable.R",
                  "./R/ErrorCheck.R",
                  "./R/ReadWriteToFile.R",
                  "./R/JoinDataToDF.R",
                  "./R/RenameColumn.R",
                  "./R/SupplementDMTable.R")

lapply(script_files, source, echo = F, verbose = F)

base_tbl <- load_base_table()
jobs_tbl <- load_jobs_table()

mstr_tbl <- left_join(jobs_tbl, base_tbl, by = c("JOBS_PIDM" = "BASE_PIDM"))
mstr_tbl <- fix_col_types(mstr_tbl)
active_emps <- mstr_tbl[,"BASE_EMP_STATUS" == "A"]
active_jobs <- mstr_tbl[,"JOBS_STATUS" == "A"]

org_lu_location <- "./src/org_lookup.csv"
mstr_tbl <- AddOrgHierarchy(mstr_tbl, org_lu_location, "JOBS_CALCULATED_DEPT_NUM")
mstr_tbl <- AddEETypeRollup(mstr_tbl, "JOBS_ECLS", "JOBS_SUFF", "JOBS_MUS_CONTRACT")
#mstr_tbl <- AddFullPartTimeStatus(mstr_tbl, "JOBS_FTE")

mstr_tbl <- fix_col_types(mstr_tbl)

bz_tbl <- mstr_tbl[mstr_tbl$JOBS_CAMPUS == "BZ",]
bz_active <- bz_tbl[bz_tbl$JOBS_STATUS == "A",]



WriteToFile(df = bz_tbl, fname = "BZ_DM_Rows.csv", fpath = "./out/")
