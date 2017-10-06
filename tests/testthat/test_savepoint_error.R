context('trying to trip the SAVEPOINT error')

test_that('This code creates a SAVEPOINT error with a large tmp table',{
  df <- data.frame(numbers = seq_len(1))
  connection <- DBI::dbConnect(odbc::odbc(), 'Allovue Test')
  expect_silent(test_tmp_tables(connection, df))
  DBI::dbDisconnect(connection)

  df <- data.frame(numbers = seq_len(1000))
  connection <- DBI::dbConnect(odbc::odbc(), 'Allovue Test')
  expect_silent(test_tmp_tables(connection, df))
  DBI::dbDisconnect(connection)

  df <- data.frame(numbers = seq_len(1024))
  connection <- DBI::dbConnect(odbc::odbc(), 'Allovue Test')
  expect_silent(test_tmp_tables(connection, df))
  DBI::dbDisconnect(connection)

  df <- data.frame(numbers = seq_len(1025))
  connection <- DBI::dbConnect(odbc::odbc(), 'Allovue Test')
  expect_silent(test_tmp_tables(connection, df))
  DBI::dbDisconnect(connection)
})