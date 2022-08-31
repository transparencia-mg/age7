context("dm_favorecido_scdp")

dm_favorecido_scdp <- fread(here::here("data/dm_favorecido_scdp.csv.gz"))

#==============================================================================

test_that("Anonimização CPF", {
  
  rules <- validate::validator(grepl("\\*\\*\\*.\\d{3}.\\d{3}-\\*\\*", nr_cpf_anonimizado))
  report <- validate::confront(dm_favorecido_scdp, rules)
  
  expect_false(summary(report)[["error"]]) 
  expect_equal(summary(report)[["fails"]], expected = 0)
})