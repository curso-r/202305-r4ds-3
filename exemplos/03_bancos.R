
# install.packages("DBI")
# install.packages("duckdb")
library(DBI)
con <- dbConnect(duckdb::duckdb(), dbdir = "data-raw/duck")

library(tidyverse)
racoes <- read_csv("data-raw/racoes.csv")

dbWriteTable(con, "racoes", racoes)

dbListTables(con)

# # Se quisermos empilhar uma base em partes!
# dbAppendTable(con, "racoes", racoes_parte2)

con |>
  dbReadTable("racoes") |>
  as_tibble()

con |>
  dbGetQuery("SELECT * FROM racoes") |>
  as_tibble()

library(dbplyr)

racoes <- tbl(con, "racoes")
racoes

racoes |>
  filter(idade < 3) |>
  select(id:refeicoes) |>
  mutate(letras = str_length(nome))

racoes |>
  filter(idade < 3) |>
  select(id:refeicoes) |>
  mutate(letras = str_length(nome)) |>
  show_query()

# Não funciona!
racoes |>
  filter(idade < 3) |>
  select(id:refeicoes) |>
  mutate(vogais = str_count(nome, "[aeiou]"))

racoes |>
  filter(idade < 3) |>
  select(id:refeicoes) |>
  collect() |>
  mutate(vogais = str_count(nome, "[aeiou]"))

dbWriteTable(con, "diamantes", diamonds)

diamantes <- tbl(con, "diamantes")
diamantes # Não sabemos o número de linhas!

diamantes |>
  filter(carat > 0.3) # Continua sem saber!

diamantes |>
  filter(carat > 0.3) |>
  collect()

# Para sobrescrever uma tabela dentro do BD
dbWriteTable(con, "racoes", racoes_modificada)



x |>
  filter() |>
  mutate() |>
  summarise() |>
  left_join(y)

y |>
  filter() |>
  mutate() |>
  summarise() |>
  right_join(x)

treinos <- read_csv("data-raw/treinos.csv")
profs <- read_csv("data-raw/profs.csv")

treinos |>
  mutate(
    data = data - years(1),
    ano = year(data),
    semestre = semester(data)
  ) |>
  left_join(profs)

treinos |>
  mutate(
    data = data - years(1),
    ano = year(data),
    semestre = semester(data)
  ) |>
  left_join(profs, join_by(ano, semestre))

treinos_semestre <- treinos |>
  mutate(
    data = data - years(1),
    ano = year(data),
    semestre = semester(data)
  )

profs |>
  semi_join(treinos_semestre)

profs |>
  anti_join(treinos_semestre)

treinos |>
  mutate(
    data = data - years(1),
    ano = year(data),
    semestre = semester(data)
  ) |>
  semi_join(profs, y = _)


join_by(ano == ano, semestre == semestre)
join_by(ano, semestre)

join_by(
  ano_treino == ano_aulas,
  semestre_treino == semestre_aulas
)

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

x |>
  left_join(y, join_by(key >= key))

x |>
  left_join(y, join_by(closest(key >= key)))
