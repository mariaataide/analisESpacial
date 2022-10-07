#' Identifica os outliers e a distância de Cook para todos os anos do painel e todas as opções de matriz de pesos espaciais disponíveis no pacote
#'
#' @return Uma tabela com os outliers e a distância de Cook.
#' @export
#'
#' @examples
#' # Identificando outliers e distância de Cook para todos os anos e matrizes
#' todos_outliers()
#'
todos_outliers <- function() {

  anos <- c(2015:2019)
  matrizes <- list(mat_idw, mat_idw_100_km, mat_idw_50_km, mat_queen)
  nomes <- c("IDW", "IDW 100 KM", "IDW 50 KM", "QUEEN")

  lista_dfs <- vector("list")

  for (ano in anos) {
    outliers <- purrr::map2_dfr(
      .x = matrizes,
      .y = nomes,
      .f = ~identificar_outliers(
        ano,
        .x,
        .y
      )
    )

    lista_dfs[[ano]] <- outliers

  }

  outliers <- do.call(rbind, lista_dfs)

  outliers |>
    huxtable::as_huxtable() |>
    huxtable::set_tb_borders() |>
    #huxtable::set_text_color("cyan3") |>
    huxtable::set_header_cols(1:4, TRUE)
}
