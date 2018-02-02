#' getSamplesSQLite3Proj
#'
#' Query the SQLite3 MIDB database for all samples
#' associated with a specific project.
#'
#' @param projID project ID String for query, e.g. "QM17-01-06"
#' @param dbPath path to database, e.g. "M:/sqlite-midb/midb.db"
#' @param csvOut path for csv, e.g. "../dat/csv/samples.csv"
#'
#' @export
#'
#' @examples
#' # not run
getSamplesSQLite3Proj <- function(projID,
                                  dbPath,
                                  csvOut){
  library(RSQLite)
  con <- dbConnect(RSQLite::SQLite(), dbname=dbPath)
  tables <- dbListTables(con)
  query = sprintf("select Lab_ID,Client_Sample_ID,Sample_Info,Date_In,Date_Out from samples where PROJECT_ID = \"%s\" ", projID)
  res <- dbSendQuery(con, query)
  samples <-fetch(res, n = -1)
  samples$Lab_ID <- tolower(samples$Lab_ID)
  print(tail(samples))
  write.csv(samples, csvOut, row.names=FALSE)
  dbDisconnect(con)
}
