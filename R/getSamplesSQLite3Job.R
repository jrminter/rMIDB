#' getSamplesSQLite3Job
#'
#' Query the SQLite3 MIDB database for all samples
#' associated with a specific job.
#'
#' @param jobID  jobID String for query, e.g. "QM17-01-06A"
#' @param dbPath path to database, e.g. "M:/sqlite-midb/midb.db"
#' @param csvOut path for csv, e.g. "../dat/csv/samples.csv"
#'
#' @export
#'
#' @examples
#' # not run
getSamplesSQLite3Job <- function(jobID,
                                 dbPath,
                                 csvOut){
  library(RSQLite)
  con <- dbConnect(RSQLite::SQLite(), dbname=dbPath)
  tables <- dbListTables(con)
  query = sprintf("select Lab_ID,Client_Sample_ID,Sample_Info,Date_In,Date_Out from samples where JOB_ID = \"%s\" ", jobID)
  res <- dbSendQuery(con, query)
  samples <-fetch(res, n = -1)
  samples$Lab_ID <- tolower(samples$Lab_ID)
  print(tail(samples))
  write.csv(samples, csvOut, row.names=FALSE)
  dbDisconnect(con)
}
