# testbug

The goal of testbug is to show a bug I think I found

## Output of failed test

This only happens when running with `devtools::test()` or R CMD tools on Mac OS.

I do not see these errors on Linux.


``` r
==> devtools::test()

Loading testbug
Loading required package: testthat
Loading required package: dplyr

Attaching package: ‘dplyr’

The following object is masked from ‘package:testthat’:

    matches

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

Testing testbug
trying to trip the SAVEPOINT error: ...1...2

Failed -------------------------------------------------------------------------
1. Error: This code creates a SAVEPOINT error with a large tmp table (@test_savepoint_error.R#21) 
nanodbc/nanodbc.cpp:1587: HY000: internal SAVEPOINT failed 
1: expect_silent(test_tmp_tables(connection, df)) at /Users/jason/code/testbug/tests/testthat/test_savepoint_error.R:21
2: evaluate_promise(object)
3: with_sink(temp, withCallingHandlers(withVisible(code), warning = handle_warning, 
       message = handle_message))
4: withCallingHandlers(withVisible(code), warning = handle_warning, message = handle_message)
5: withVisible(code)
6: test_tmp_tables(connection, df)
7: copy_to(dest = connection, df = my_data, name = "tmp_data", overwrite = TRUE, temporary = TRUE) at /Users/jason/code/testbug/R/hello.R:5
8: copy_to.DBIConnection(dest = connection, df = my_data, name = "tmp_data", overwrite = TRUE, 
       temporary = TRUE)
9: copy_to(dbplyr::src_dbi(dest), df = df, name = name, overwrite = overwrite, ...)
10: copy_to.src_sql(dbplyr::src_dbi(dest), df = df, name = name, overwrite = overwrite, 
       ...)
11: db_copy_to(dest$con, name, df, overwrite = overwrite, types = types, temporary = temporary, 
       unique_indexes = unique_indexes, indexes = indexes, analyze = analyze, ...)
12: db_copy_to.OdbcConnection(dest$con, name, df, overwrite = overwrite, types = types, 
       temporary = temporary, unique_indexes = unique_indexes, indexes = indexes, analyze = analyze, 
       ...)
13: dbWriteTable(con, table, values, temporary = temporary)
14: dbWriteTable(con, table, values, temporary = temporary)
15: .local(conn, name, value, ...)
16: tryCatch(result_insert_dataframe(rs@ptr, values), finally = dbClearResult(rs))
17: tryCatchList(expr, classes, parentenv, handlers)
18: result_insert_dataframe(rs@ptr, values)

2. Error: This code does not create a SAVEPOINT error with a large tmp table (@test_savepoint_error.R#49) 
nanodbc/nanodbc.cpp:1587: HY000: internal SAVEPOINT failed 
1: expect_silent(test_tmp_tables(connection, df)) at /Users/jason/code/testbug/tests/testthat/test_savepoint_error.R:49
2: evaluate_promise(object)
3: with_sink(temp, withCallingHandlers(withVisible(code), warning = handle_warning, 
       message = handle_message))
4: withCallingHandlers(withVisible(code), warning = handle_warning, message = handle_message)
5: withVisible(code)
6: test_tmp_tables(connection, df)
7: copy_to(dest = connection, df = my_data, name = "tmp_data", overwrite = TRUE, temporary = TRUE) at /Users/jason/code/testbug/R/hello.R:5
8: copy_to.DBIConnection(dest = connection, df = my_data, name = "tmp_data", overwrite = TRUE, 
       temporary = TRUE)
9: copy_to(dbplyr::src_dbi(dest), df = df, name = name, overwrite = overwrite, ...)
10: copy_to.src_sql(dbplyr::src_dbi(dest), df = df, name = name, overwrite = overwrite, 
       ...)
11: db_copy_to(dest$con, name, df, overwrite = overwrite, types = types, temporary = temporary, 
       unique_indexes = unique_indexes, indexes = indexes, analyze = analyze, ...)
12: db_copy_to.OdbcConnection(dest$con, name, df, overwrite = overwrite, types = types, 
       temporary = temporary, unique_indexes = unique_indexes, indexes = indexes, analyze = analyze, 
       ...)
13: dbWriteTable(con, table, values, temporary = temporary)
14: dbWriteTable(con, table, values, temporary = temporary)
15: .local(conn, name, value, ...)
16: tryCatch(result_insert_dataframe(rs@ptr, values), finally = dbClearResult(rs))
17: tryCatchList(expr, classes, parentenv, handlers)
18: result_insert_dataframe(rs@ptr, values)

DONE ===========================================================================
```
Opening a fresh R session and loading `DBI`, `odbc`, and `dplyr`:

```r
> sessionInfo()
R version 3.4.2 (2017-09-28)
Platform: x86_64-apple-darwin15.6.0 (64-bit)
Running under: macOS High Sierra 10.13

Matrix products: default
BLAS: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
LAPACK: /Library/Frameworks/R.framework/Versions/3.4/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] dplyr_0.7.4 DBI_0.7     odbc_1.1.1 

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.12     assertthat_0.2.0 R6_2.2.2         magrittr_1.5    
 [5] rlang_0.1.2      blob_1.1.0       bindrcpp_0.2     tools_3.4.2     
 [9] bit64_0.9-7      glue_1.1.1       bit_1.1-12       hms_0.3         
[13] yaml_2.1.14      compiler_3.4.2   pkgconfig_2.0.1  bindr_0.1       
[17] tibble_1.3.4    
```


## PostgreSQL Info

* PostgreSQL 9.6.3

```bash
> odbcinst -j
unixODBC 2.3.4
DRIVERS............: /usr/local/Cellar/unixodbc/2.3.4/etc/odbcinst.ini
SYSTEM DATA SOURCES: /usr/local/Cellar/unixodbc/2.3.4/etc/odbc.ini
FILE DATA SOURCES..: /usr/local/Cellar/unixodbc/2.3.4/etc/ODBCDataSources
USER DATA SOURCES..: /Users/jason/.odbc.ini
SQLULEN Size.......: 8
SQLLEN Size........: 8
SQLSETPOSIROW Size.: 8

> cat /Users/jason/.odbc.ini
[Allovue Test]
Driver              = PostgreSQL Driver
Database            = allovue_test
Servername          = localhost
UserName            = postgres
Password            =
Port                = 5432
ShowOidColumn       = No
FakeOidIndex        = No
BoolsAsChar         = No
```
