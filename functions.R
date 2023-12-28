print("functions.R")
# clean_unemp() is a function inside a package I made. Because I don't want you to install
# the package if you're following along, I'm simply sourcing it:
clean_unemp <- function(unemp_data,
                        year_of_interest = NULL,
                        place_name_of_interest = NULL,
                        level_of_interest = NULL,
                        col_of_interest){

  if(is.null(year_of_interest)){

    year_of_interest <- quo(year)

  }

  if(is.null(place_name_of_interest)){

    place_name_of_interest <- quo(place_name)

  }

  if(is.null(level_of_interest)){

    level_of_interest <- quo(level)

  }

  result <- unemp_data |>
    janitor::clean_names() |>
    dplyr::filter(year %in% !!year_of_interest,
                  place_name %in% !!place_name_of_interest,
                  level %in% !!level_of_interest) |>
    dplyr::select(year, place_name, level, {{col_of_interest}})

  if(nrow(result) == 0) {
    warning("The returned data frame is empty. This is likely because the `place_name_of_interest` or `level_of_interest` argument supplied does not match any rows in the original data.")
  }
  result
}



# The cleaned data is also available in that same package. But again, because I don't want you
# to install a package just for a blog post, here is the script to clean it.
# Don't waste time trying to understand it, it's very specific to the data I'm using
# to illustrate the concept of reproducible analytical pipelines. Just accept this data 
# as given.

# This is a helper function to clean the data
clean_data <- function(x){
  print("clean_data")
  x %>%
    janitor::clean_names() %>%
    mutate(level = case_when(
             grepl("Grand-D.*", commune) ~ "Country",
             grepl("Canton", commune) ~ "Canton",
             !grepl("(Canton|Grand-D.*)", commune) ~ "Commune"
           ),
           commune = ifelse(grepl("Canton", commune),
                            stringr::str_remove_all(commune, "Canton "),
                            commune),
           commune = ifelse(grepl("Grand-D.*", commune),
                            stringr::str_remove_all(commune, "Grand-Duche de "),
                            commune),
           ) %>%
    select(year,
           place_name = commune,
           level,
           everything())
}

# This reads in the data.
get_data <- function(){
  print("unemp_data")
  urls <- list(
    "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2013.csv",
    "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2014.csv",
    "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2015.csv",
    "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2016.csv"
  )
  print(urls)
  urls |>
    purrr::map_dfr(readr::read_csv) %>%
    purrr::map_dfr(clean_data)
}

# This plots the data
make_plot <- function(data){
  ggplot(data) +
    geom_col(
      aes(
        y = active_population,
        x = year,
        fill = place_name
      )
    ) +
    theme(legend.position = "bottom",
          legend.title = element_blank())
}

# This saves plots to disk
save_plot <- function(save_path, plot){
  ggsave(save_path, plot)
  save_path
}
