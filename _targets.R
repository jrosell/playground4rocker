print("_targets.R")
library(targets)
library(dplyr)
library(ggplot2)
source("functions.R")


list(
    tar_target(
        unemp_data,
        get_data()
    ),

    tar_target(
        lux_data,
        clean_unemp(unemp_data,
                    place_name_of_interest = "Luxembourg",
                    level_of_interest = "Country",
                    col_of_interest = active_population)
    ),

    tar_target(
        canton_data,
        clean_unemp(unemp_data,
                    level_of_interest = "Canton",
                    col_of_interest = active_population)
    ),

    tar_target(
        commune_data,
        clean_unemp(unemp_data,
                    place_name_of_interest = c("Luxembourg",
                                               "Dippach",
                                               "Wiltz",
                                               "Esch/Alzette",
                                               "Mersch"),
                    col_of_interest = active_population)
    ),

    tar_target(
        lux_plot,
        make_plot(lux_data)
    ),

    tar_target(
        canton_plot,
        make_plot(canton_data)
    ),

    tar_target(
        commune_plot,
        make_plot(commune_data)
    ),

    tar_target(
        luxembourg_saved_plot,
        save_plot("/home/fig/luxembourg.png", lux_plot),
        format = "file"
    ),

    tar_target(
        canton_saved_plot,
        save_plot("/home/fig/canton.png", canton_plot),
        format = "file"
    ),

    tar_target(
        commune_saved_plot,
        save_plot("/home/fig/commune.png", commune_plot),
        format = "file"
    )


)
