#' @importFrom dplyr copy_to
#' @importFrom dplyr tbl

test_tmp_tables <- function(connection, my_data){
  copy_to(dest = connection,
          df = my_data,
          name = 'tmp_data',
          overwrite = TRUE,
          temporary = TRUE)
  tbl(connection, 'tmp_data')
}

#' @importFrom dplyr src_postgres
test_dplyr_native_copy <- function(my_data){
  connection <- dplyr::src_postgres('allovue_test', 'localhost', '5432', 'postgres')
  copy_to(dest = connection,
          df = my_data,
          name = 'tmp_data',
          overwrite = TRUE,
          temporary = TRUE)
  tbl(connection, 'tmp_data')
}