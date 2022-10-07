#' Conta quantos estão em cada cluster
#'
#' @param ano_num `numric`. Ano.
#' @param tipo_matriz Um objeto `listw` ou `matrix`. Uma matriz de pesos espaciais para o Espirito Santo.
#' @param nome_matriz `character`. Um rótulo que identifique a matriz de pesos espaciais.
#'
#' @return Um `tibble` que pode conter de 2 a 5 linhas e 4 colunas.
#' @export
#'
#' @examples
#' # Quatidade de municípios por cluster para o ano de 2015, usando a matriz IDW.
#' contar_cluster(2015, mat_idw, "IDW")
#'
contar_cluster <- function(ano_num, tipo_matriz, nome_matriz) {

  suppressMessages(prep_dados_aede(ano_num, tipo_matriz)) |>
    sf::st_drop_geometry() |>
    dplyr::select(cluster) |>
    dplyr::group_by(cluster) |>
    dplyr::count(name = "freq_abs", cluster) |>
    dplyr::ungroup()|>
    dplyr::mutate(
      matriz = nome_matriz,
      freq_rel = freq_abs / sum(freq_abs) * 100
    ) |>
    dplyr::relocate(matriz, .before = dplyr::everything())
}
