outlb <- Microsoft365R::get_business_outlook()

body <- blastula::render_email(here::here("scripts", "r", "notify.Rmd"))

exit_code <- as.numeric(readLines(here::here("logs/exit-code.txt")))
status <- ifelse(exit_code == 0, "SUCESSO", "FRACASSO")

em <- outlb$create_email(body,
                         subject = glue::glue("[{status}] Atualizacao age7 em: {file.mtime('logs/exit-code.txt')}"),
                         to = "catalogo.dadosabertos@cge.mg.gov.br")
em$send()
