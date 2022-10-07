## code to prepare `sf_munES` dataset goes here

munES_geoms <- sf::st_centroid(sf_munES)

munES_nb <- spdep::dnearneigh(munES_geoms, 0, 600) #matriz simétrica

sf_munES <-
  sf::read_sf("G:/Meu Drive/Aritgo monografia/Scripts/Modelos/ES_Municipios_2021/ES_Municipios_2021.shp") |>
  dplyr::select(nm_mun = NM_MUN, geometry) |>
  dplyr::mutate(
    nm_mun = stringr::str_to_upper(nm_mun),
    nm_mun = ifelse(nm_mun == "ATÍLIO VIVÁCQUA",
                    "ATÍLIO VIVACQUA", nm_mun)
  )

## Remove pequenos polígonos separados (ilhas) -----

sf_munES <-
  rmapshaper::ms_filter_islands(
    input = sf_munES,
    min_area = min(sf::st_area(sf_munES))
  )

usethis::use_data(sf_munES, overwrite = TRUE)
