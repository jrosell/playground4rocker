cat("_targets.R\n")

# Here I'm interested in the github actions and docker deployment workflows.
# So, I used and updated the code from https://www.brodrigues.co/blog/2022-11-19-raps/ by @b-rodrigues
# An example can also be seen here https://github.com/b-rodrigues/dockerized_pipeline_demo

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
        save_plot("output/luxembourg.png", lux_plot),
        format = "file"
    ),

    tar_target(
        canton_saved_plot,
        save_plot("output/canton.png", canton_plot),
        format = "file"
    ),

    tar_target(
        commune_saved_plot,
        save_plot("output/commune.png", commune_plot),
        format = "file"
    )


)
