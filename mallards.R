library(tidyverse)
library(lubridate)
library(sf)

mallards <- read_csv("data/mallards.csv") |>
  mutate(
    timestamp = ymd_hms(timestamp),
    date = as.Date(timestamp),
    year = year(timestamp),
    month = month(timestamp),
    season = case_when(
      month %in% c(12, 1, 2) ~ "Winter",
      month %in% c(3, 4, 5) ~ "Spring",
      month %in% c(6, 7, 8) ~ "Summer",
      TRUE ~ "Fall"
    ),
    duck_id = as.character(duck_id),
    taxon = as.character(taxon)
  ) |>
  arrange(timestamp) |>
  st_as_sf(coords = c("long", "lat"), crs = 4326, remove = FALSE)

saveRDS(mallards, "data/mallards.rds")
