#' Resultados dos testes ML robusto para dependência espacial no termo de erro e na variável dependente para todas as matrizes diponíveis.
#'
#' @return Um `tibble` com 4 linhas e 3 colunas.
#' @export
#'
#' @examples
#' # Comparando os reusltados dos testes ML Erro Robusto e ML Lag Robusto
#' resultados_teste_ML_robusto()
#'
resultados_teste_ML_robusto <- function() {

  tipoTesteML <- c("rlme", "rlml")
  matrizes <- list(mat_idw, mat_idw_100_km, mat_idw_50_km, mat_queen)
  nomes <- c("IDW", "IDW 100 KM", "IDW 50 KM", "QUEEN")
  lista <- vector("list", length = 2)

  for (tipo in tipoTesteML) {
    df <- purrr::map2_dfr(
      .x = matrizes,
      .y = nomes,
      .f = ~ extrair_pvalor_teste_ML_robusto(
        tipo_matriz = .x,
        tipo_teste = tipo,
        nome_matriz = .y
      )
    )

    lista[[tipo]] <- df

  }

  do.call(rbind, lista)|>
    tidyr::pivot_wider(
      names_from = Teste,
      values_from = `p-valor`
    ) |>
    print()
}
