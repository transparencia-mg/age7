context("dm_favorecido")

dm_favorecido <- fread(here::here("data/dm_favorecido.csv.gz"))

#==============================================================================

test_that("Anonimização CPF", {
  
  rules <- validate::validator(if(tp_documento == 1) grepl("\\*\\*\\*.\\d{3}.\\d{3}-\\*\\*|0", nr_documento_anonimizado))
  report <- validate::confront(dm_favorecido, rules)
  
  expect_false(summary(report)[["error"]]) 
  expect_equal(summary(report)[["fails"]], expected = 0)
})

test_that("Anonimização prêmios lotéricos", {

  get_id_favorecido_premios_lotericos <- function(x) {
    path_ft_despesa <- here::here(glue::glue("data/ft_despesa_{x}.csv.gz"))
    path_ft_restos_pagar <- here::here(glue::glue("data/ft_restos_pagar_{x}.csv.gz"))
    dm_unidade_orc <- fread(here::here("data/dm_unidade_orc.csv.gz"))
    
    ft_despesa <- fread(path_ft_despesa)[id_elemento == 494 & id_item == 2878]
    id_favorecido_despesa <- dm_unidade_orc[ft_despesa, on = "id_unidade_orc"][cd_unidade_orc == 2041, id_favorecido]
    
    ft_restos_pagar <- fread(path_ft_restos_pagar)[id_elemento == 494 & id_item == 2878]
    id_favorecido_restos_pagar <- dm_unidade_orc[ft_despesa, on = "id_unidade_orc"][cd_unidade_orc == 2041, id_favorecido]
    
    unique(c(id_favorecido_despesa, id_favorecido_restos_pagar))
  }
  
  
  premios_lotericos <- unlist(map(2002:2022, get_id_favorecido_premios_lotericos))
    
  dm_favorecido[
    id_favorecido %in% premios_lotericos, 
    is_premios_lotericos := TRUE
  ]
  
  rules <- validate::validator(if(is_premios_lotericos == TRUE & tp_documento == 1) nr_documento_anonimizado == 0 & nome_anonimizado == "INFORMACAO COM RESTRICAO DE ACESSO")
  report <- validate::confront(dm_favorecido, rules)
  
  expect_false(summary(report)[["error"]]) 
  expect_equal(summary(report)[["fails"]], expected = 0)
  
})


test_that("Anonimização hanseniase 2021", {

  ft_despesa_2021 <- dtamg::flatten_resource(here::here("datapackage.json"), 
                                             "ft_despesa_2021",
                                             c("dm_empenho_desp_2021", "dm_unidade_orc", "dm_favorecido"))
  
  hanseniase <- ft_despesa_2021[
    cd_unidade_orc == 4291 & cd_uni_prog_gasto == 761,
    unique(id_favorecido)
  ]
    
  dm_favorecido[
    id_favorecido %in% hanseniase, 
    is_hanseniase := TRUE
  ]
  
  rules <- validate::validator(if(is_hanseniase == TRUE & tp_documento == 1) nr_documento_anonimizado == 0 & nome_anonimizado == "INFORMACAO COM RESTRICAO DE ACESSO")
  report <- validate::confront(dm_favorecido, rules)
  
  expect_false(summary(report)[["error"]]) 
  expect_equal(summary(report)[["fails"]], expected = 0)
})

test_that("Anonimização hanseniase 2022", {

  ft_despesa_2022 <- dtamg::flatten_resource(here::here("datapackage.json"), 
                                             "ft_despesa_2022",
                                             c("dm_empenho_desp_2022", "dm_unidade_orc", "dm_favorecido"))
  
  hanseniase <- ft_despesa_2022[
    cd_unidade_orc == 4291 & cd_uni_prog_gasto == 761,
    unique(id_favorecido)
  ]
    
  dm_favorecido[
    id_favorecido %in% hanseniase, 
    is_hanseniase := TRUE
  ]
  
  rules <- validate::validator(if(is_hanseniase == TRUE & tp_documento == 1) nr_documento_anonimizado == 0 & nome_anonimizado == "INFORMACAO COM RESTRICAO DE ACESSO")
  report <- validate::confront(dm_favorecido, rules)
  
  expect_false(summary(report)[["error"]]) 
  expect_equal(summary(report)[["fails"]], expected = 0)
})