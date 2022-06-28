library(terragee)

# terragee::set_google_application_credentials("...")

.sprcres(EEImageCollection("projects/earthengine-public/assets/COPERNICUS/S2", n = 2))

EEImageCollection("projects/earthengine-public/assets/COPERNICUS/S2", n = 2) |>
  .splitsprc_res(mosaic = TRUE) -> x
