context("dm_contratado")

dm_contratado <- fread(here::here("data/dm_contratado.csv.gz"))

#==============================================================================

test_that("Anonimização CPF", {
  
  rules <- validate::validator(if(tp_documento == 1) grepl("\\*\\*\\*\\d{3}\\d{3}\\*\\*", nr_documento_anonimizado))
  report <- validate::confront(dm_contratado, rules)
  
  expect_false(summary(report)[["error"]]) 
  expect_equal(summary(report)[["fails"]], expected = 0)
})