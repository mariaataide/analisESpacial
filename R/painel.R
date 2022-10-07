#' Painel
#'
#' Um painel de dados contendo variáveis fiscais, políticas e demográficas.
#'
#' @format Contém 35 colunas e 390 linhas.
#' \describe{
#'   \item{nm_mun}{Municípios do Espírito Santo.}
#'   \item{ano}{Ano.}
#'   \item{desppc}{Despesa total per capita (em R$ milhões).}
#'   \item{desp_corr_pc}{Despesa corrente per capita (em R$ milhões).}
#'   \item{desp_cap_pc}{Despesa capital per capita (em R$ milhões).}
#'   \item{investpc}{Investimento per capita (em R$ milhões).}
#'   \item{investpc}{Investimento per capita (em R$ milhões).}
#'   \item{transfpc}{Transferências incondicionais per capita (em R$ milhões).}
#'   \item{royaltiespc}{Royalties per capita (em R$ milhões).}
#'   \item{pibpc}{PIB per capita (em R$ milhões).}
#'   \item{log_desppc}{Logarítmo da despesa total per capita.}
#'   \item{log_transfpc}{Logarítmo das transferências incodicionais per capita.}
#'   \item{log_pibpc}{Logarítmo do PIB per capita.}
#'   \item{pop}{População.}
#'   \item{ind}{Participação % da indústria no valor adicionado bruto (VAB).}
#'   \item{frag}{Fragmentação política.}
#'   \item{ideo}{Ideologia.}
#'   \item{f_pol}{Força política.}
#'   \item{fx_pop1}{1 caso população <= 50 mil habitante, 0 caso contrátio.}
#'   \item{fx_pop2}{1 caso população > 50 mil e < 300 mil, 0 caso contrátio.}
#'   \item{fx_pop3}{1 caso população > 300 mil, 0 caso contrátio.}
#'   \item{regiao}{Microrregiões.}
#'   \item{c_serrana}{Dummy Central Serrana.}
#'   \item{s_serrana}{Dummy Sudoeste Serrana.}
#'   \item{l_sul}{Dummy Litoral Sul.}
#'   \item{c_sul}{Dummy Central Sul.}
#'   \item{caparao}{Dummy Caparaó.}
#'   \item{r_doce}{Dummy Rio Doce.}
#'   \item{c_oeste}{Dummy Centro-Oeste.}
#'   \item{nordeste}{Dummy Nordeste.}
#'   \item{sudene}{Dummy Sudene.}
#'   \item{eleicoes}{Ano eleitoral.}
#'   \item{alin_gov}{Alinhamento com partido do governador}
#'   \item{alin_pres}{Alinhamento com partido do presidente}
#' }
#' @source Elaboração própria a partir de dados do IJSN, IBGE, Tesouro Transparente, Siconfi, SEFAZ/ES, TSE e BLS.
"painel"
