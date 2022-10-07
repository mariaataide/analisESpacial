#' Identifica quais observações são outliers
#'
#' @param ano `numeric`. Ano.
#' @param tipo_matriz `listw` ou `matrix`. Uma matriz de pesos espaciais para o Espirito Santo.
#' @param nome_matriz Um rótulo que identifique a matriz de pesos espaciais.
#'
#' @return Um `tibble` com 4 linhas e 4 colunas, contendo os outliers e a distância de Cook o ano selecionado.
#' @export
#'
#' @examples
#' # Verificando outliers e a distância de Cook para 2015.
#' identificar_outliers(2015, mat_idw, "IDW")
#'
identificar_outliers <- function(ano, tipo_matriz, nome_matriz) {

  olsrr::ols_prep_cdplot_outliers(olsrr::ols_prep_cdplot_data(
    stats::lm(w_log_desppc_pad ~ log_desppc_pad,
       data = suppressMessages(prep_dados_aede(ano, tipo_matriz)))
  )) |>
    tibble::tibble() |>
    dplyr::mutate(ano = ano, matriz = nome_matriz) |>
    dplyr::relocate(ano, matriz, .before = dplyr::everything())

}
