#' Extrai o p-valor do teste ML robusto
#'
#' @param tipo_matriz `listw` ou `matrix`.  Uma matriz de pesos espaciais para o Espírito Santo.
#' @param tipo_teste "rlml" ou "rlme". Testar dependência espacial na variável dependente("rlml") ou no termo de erro ("rlme").
#' @param nome_matriz Um rótulo para a matriz de pesos espaciais.
#'
#' @return Um `tibble` com linha e 3 colunas.
#' @export
#'
#' @examples
#' # p-valor do teste ML robusto para dependência espacial na variável dependente
#' extrair_pvalor_teste_ML_robusto(mat_idw, "rlml", "IDW")
#'
extrair_pvalor_teste_ML_robusto <- function(tipo_matriz, tipo_teste, nome_matriz) {

  modeloEsp <-
    log_desppc ~ log_transfpc + log_pibpc + pop + ind + ideo + frag +
    f_pol + alin_gov + alin_pres + eleicoes

  teste <- splm::slmtest(modeloEsp, data = painel, listw = tipo_matriz,
                         test = tipo_teste, model = "within")

  tibble::tibble(
    Matriz = nome_matriz,
    Teste = ifelse(tipo_teste == "rlml", "ML Lag Robusto", "ML Erro Robusto"),
    `p-valor` = teste$p.value[1, ]
  )

}
