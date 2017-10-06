context('trying to trip the SAVEPOINT error')

test_that('This code creates a SAVEPOINT error with a large tmp table',{
  df <- data.frame(date = seq.Date(as.Date('2010-09-01'),
                                   as.Date('2020-09-01'),
                                   length.out = 25000),
                   numbers = rnorm(1000, 200,n = 25000))
  connection <- DBI::dbConnect(odbc::odbc(), 'Allovue Test')
  expect_silent(test_tmp_tables(connection, df))
  dbDisconnect(connection)
})