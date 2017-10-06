#' @importFrom dplyr copy_to
#' @importFrom dplyr tbl

test_tmp_tables <- function(connection, my_data){
  copy_to(dest = connection, df = my_data, name = 'tmp_data', overwrite = TRUE)
  tbl(connection, 'tmp_data')
}