
expect_equal(terragee:::.EEDAI("projects/earthengine-public/assets/COPERNICUS/S2"),
             "EEDAI:projects/earthengine-public/assets/COPERNICUS/S2")

expect_equal(terragee:::.EEDA("projects/earthengine-public/assets/COPERNICUS/S2"),
             "EEDA:projects/earthengine-public/assets/COPERNICUS/S2")

expect_equal(get_asset_ogr_table_name("projects/earthengine-public/assets/COPERNICUS/S2"),
             "projects_earthengine_public_assets_COPERNICUS_S2")

