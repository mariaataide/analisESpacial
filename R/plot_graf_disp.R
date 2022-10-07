
#' Plota o gráfico de dispersão de Moran
#'
#' @param dados Um objeto `tibble` com 78 linhas e 43 colunas gerado pela função [prep_dados_aede].
#'
#' @return Um gráfico de dispersão de Moran.
#' @export
#'
#' @examples
#' # Plota o gráfico de dispersão de Moran
#' prep_dados_aede(2015, mat_queen) |> plot_graf_disp()
#'
plot_graf_disp <- function(dados) {
  dados |>
    ggplot2::ggplot(ggplot2::aes(x = log_desppc_pad, y = w_log_desppc_pad)) +
    ggplot2::geom_point(ggplot2::aes(colour = factor(quadrante))) +
    ggplot2::scale_colour_manual(values = c("#EE0000", "#F98866", "#90EE90", "#006400")) +
    ggplot2::geom_smooth(method = "lm", se = F) +
    #ggrepel::geom_text_repel(ggplot2::aes(label = nm_mun), size = 1.7) +
    ggplot2::geom_hline(yintercept = 0) +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.title = ggplot2::element_blank()) +
    ggplot2::labs(x = "log(desppc)",
                  y = "W*log(desppc)") +
    ggplot2::ggtitle(paste(unique(dados$ano)))
}
