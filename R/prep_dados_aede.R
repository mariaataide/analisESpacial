#' Prepara os dados para a AEDE
#'
#' A função filtra o painel de dados por ano, além de calcular o I de Moran local e agregar o p-valor do teste ao `data.frame` , usado para classificar as observações em clusters do mapa de significância LISA e quadrantes do gráfico de dispersão de Moran.
#'
#' @param year Seleciona o ano.
#' @param tipo_matriz Objeto do tipo `listw` ou `matrix` representado os pesos espaciais para os municípios do Espírito Santo. Usar os matrizes `mat_idw`, `mat_idw_100_km`, `mat_idw_50_km`, `mat_queen`i nclusas no pacote ou as funções  `spdep::nb2mat`, `spdep::nb2listw` ou `spdep::nb2listwdist` para criar uma matriz de pesos espaciais para o Espírito Santo.
#'
#' @return Um `data.frame` com 78 linhas e 43 colunas, contendo variáveis fiscais, demográficas, políticas, demográficas para os 78 municípios capixabas.
#'
#' @export
#'
#' @examples
#' #Preparar os dados para o ano 2015 e usar a matriz `mat_idw`.
#' prep_dados_aede(2015, mat_idw)
prep_dados_aede <- function(year, tipo_matriz) {
  # agrega os dados espaciais ao data.frame e modifica o vetor de nomes
  dados_aede <- analisESpacial::painel |>
    dplyr::filter(ano == year) |>
    dplyr::left_join(sf_munES) |>
    dplyr::mutate(nm_mun = stringr::str_to_title(nm_mun),
                  nm_mun = stringr::str_replace_all(nm_mun, " De ", " de "),
                  nm_mun = stringr::str_replace_all(nm_mun, " Do ", " do "),
                  nm_mun = stringr::str_replace_all(nm_mun, " Da ", " da ")) |>
    sf::st_as_sf() #|>
    #suppressMessages()
  # calcula o I de Moran local
  moran_local <-
    spdep::localmoran(dados_aede$log_desppc, listw = tipo_matriz)

  dados_aede <-  dados_aede |>
    dplyr::mutate(
      # extrai a significância estatística do I de Moran local e agrega ao data.frame
      moran_sig = moran_local[, 5],
      # computa o lag do logarítmo da despesa per capita
      w_log_desppc = spdep::lag.listw(tipo_matriz, log_desppc),
      # cria variáveis padronizadas
      log_desppc_pad = scale(log_desppc),
      log_transfpc_pad = scale(log_transfpc),
      w_log_desppc_pad = scale(w_log_desppc),
      # classifica por quadrante do gráfico de dispersão de Moran global     univariado
      quadrante = dplyr::case_when(
        log_desppc_pad >= 0 & w_log_desppc_pad  >= 0 ~ "AA",
        log_desppc_pad >= 0 & w_log_desppc_pad  < 0 ~ "AB",
        log_desppc_pad < 0 & w_log_desppc_pad  < 0 ~ "BB",
        log_desppc_pad < 0 & w_log_desppc_pad  >= 0 ~  "BA"),
      # classifica por clusters do I de Moran univariado
      cluster = dplyr::case_when(
        log_desppc >= 0 & moran_sig < 0.05 ~ "AA",
        log_desppc <= 0 & moran_sig < 0.05 ~ "BB",
        log_desppc >= 0 & moran_sig < 0.05 ~ "AB",
        log_desppc >= 0 & moran_sig < 0.05 ~ "BA",
        TRUE ~ "NS"
      )
    ) |>
    # transforma em um objeto da classe sf
    sf::st_as_sf()

}
