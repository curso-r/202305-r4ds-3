library(tidyverse)
library(dados)

dados_gapminder |>
  filter(continente %in% "Europa", ano >= 2000) |>
  group_by(ano) |>
  summarise(
    pop = sum(populacao) / 1e6,
    vida = mean(expectativa_de_vida),
    .groups = "drop"
  )

# -------------------------------------------------

calcular_estatisticas <- function(data, continentes, anos = 2000) {
  data |>
    dplyr::filter(continente %in% continentes, ano >= anos) |>
    dplyr::group_by(ano) |>
    dplyr::summarise(
      pop = sum(populacao) / 1e6,
      vida = mean(expectativa_de_vida),
      .groups = "drop"
    )
}

calcular_estatisticas_gapminder <- function(continentes, anos = 2000) {
  dados::dados_gapminder |>
    calcular_estatisticas(continentes, anos)
}


