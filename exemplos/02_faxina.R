
# Caminho para os meus dados
"materiais/dados/02_faxina/ARQUIVO"

# Caminho para os seus dados
"data-raw/ARQUIVO"

library(tidyverse)

"materiais/dados/02_faxina/racoes.csv" |>
  read_csv()

"materiais/dados/02_faxina/racoes.csv" |>
  read_csv(show_col_types = FALSE) # Silencia mensagem

# Dá errado!
"materiais/dados/02_faxina/racoes2.csv" |>
  read_csv()

"materiais/dados/02_faxina/racoes2.csv" |>
  read_csv2()

"materiais/dados/02_faxina/caes_xl.csv" |>
  read_csv()

"materiais/dados/02_faxina/caes_xl.csv" |>
  read_csv(locale = locale(encoding = "windows-1252"))

guess_encoding("materiais/dados/02_faxina/caes_xl.csv")

"materiais/dados/02_faxina/caes_xl.csv" |>
  read_csv(locale = locale(encoding = "ISO-8859-1"))

# ISO-8859-1 e windows-1252 são equivalentes!

library(readxl)

# Dá errado!
"materiais/dados/02_faxina/racoes.xlsx" |>
  read_excel()

"materiais/dados/02_faxina/racoes.xlsx" |>
  read_excel(skip = 2) # Equivalente a range = "A3:E6" (neste caso!)

"materiais/dados/02_faxina/racoes.xlsx" |>
  read_excel(
    skip = 2,
    na = c("", "-")
  )

"materiais/dados/02_faxina/racoes.xlsx" |>
  read_excel(
    skip = 2,
    na = c("", "-")
  ) |>
  janitor::clean_names()

janitor::make_clean_names(
  c("Nome", "Ração Favorita", "Refeições")
)

# Não deixa valor repetir!
janitor::make_clean_names(
  c("Nome", "Nome", "Ração Favorita", "Refeições")
)

janitor::make_clean_names(
  c("Nome", "Nome", "Ração Favorita", "Refeições"),
  allow_dupes = TRUE
)

library(googlesheets4)
gs4_auth("clente@curso-r.com", cache = FALSE) # Demonstrar auth

"materiais/dados/02_faxina/treinos.csv" |>
  read_csv() |>
  mutate(nota_b = coalesce(nota_b, mean(nota_b, na.rm = TRUE)))

"materiais/dados/02_faxina/treinos.csv" |>
  read_csv() |>
  mutate(nota_b = coalesce(nota_b, nota_a))

profs <- read_csv("materiais/dados/02_faxina/profs.csv")

"materiais/dados/02_faxina/medias.csv" |>
  read_csv() |>
  full_join(profs, join_by(ano, semestre))
