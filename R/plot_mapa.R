#' Plota o mapa de significância LISA
#'
#' @param dados Um objeto `tibble` com 78 linhas e 43 colunas gerado pela função [prep_dados_aede].
#' @param col Preencher com a variável fator `quadrante` do `tibble` retornado pela função [prep_dados_aede].
#'
#' @return Um mapa de significância LISA do Espírito Santo.
#' @export
#'
#' @examples
#' # Plotando o mapa de significância LISA.
#' prep_dados_aede(2015, mat_idw_100_km) |>
#'  plot_mapa(col = factor(quadrante))
#'
plot_mapa <- function(dados, col) {

  dados |>
    ggplot2::ggplot() +
    ggplot2::geom_sf(ggplot2::aes(fill = {{col}})) +
    ggplot2::scale_fill_brewer(palette = "PuBuGn", direction = -1) +
    #ggplot2::geom_sf_text(ggplot2::aes(label = addline_format(nm_mun)), size = 1.7) +
    ggplot2::theme_void() +
    ggplot2::theme(
      #panel.background = ggplot2::element_blank(),
      #axis.ticks = ggplot2::element_blank(),
      #axis.title = ggplot2::element_blank(),
      #axis.text = ggplot2::element_blank(),
      legend.title = ggplot2::element_blank(),
      legend.title.align = .5,
      legend.text = ggplot2::element_text(size = 10),
      legend.justification = "right"
    ) +
    ggplot2::ggtitle(paste(unique(dados$ano)))

}
