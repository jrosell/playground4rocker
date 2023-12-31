cat("functions.R\n")

# Here I'm interested in the github actions and docker deployment workflows.
# So, I used and updated the code from https://www.brodrigues.co/blog/2022-11-19-raps/ by @b-rodrigues
# An example can also be seen here https://github.com/b-rodrigues/dockerized_pipeline_demo

# clean_unemp() is a function inside a package I made. Because I don't want you to install
# the package if you're following along, I'm simply sourcing it:
source("https://raw.githubusercontent.com/b-rodrigues/myPackage/main/R/functions.R")

# The cleaned data is also available in that same package. But again, because I don't want you
# to install a package just for a blog post, here is the script to clean it.
# Don't waste time trying to understand it, it's very specific to the data I'm using
# to illustrate the concept of reproducible analytical pipelines. Just accept this data 
# as given.

# This is a helper function to clean the data
clean_data <- function(x){
  cat("clean_data\n")
  x |>
    janitor::clean_names() |>
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
           ) |>
    select(year,
           place_name = commune,
           level,
           everything())
}

# This reads in the data.
get_data <- function(){
    cat("get_data\n")
    urls <- list(
        "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2013.csv",
        "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2014.csv",
        "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2015.csv",
        "https://raw.githubusercontent.com/b-rodrigues/modern_R/master/datasets/unemployment/unemp_2016.csv"
    )
    urls |>
        purrr::map(readr::read_csv, show_col_types = FALSE) %>%
        purrr::map(clean_data) %>% 
        purrr::list_rbind()
}

# This plots the data
make_plot <- function(data){
  cat("make_plot\n")
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
