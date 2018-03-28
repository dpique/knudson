# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

hello <- function() {
  print("Hello, world!")
}

#Knudson's 2 hit hypothesis: Cited by 7590

library(devtools)
library(here)
library(tidyverse)
k <- read_tsv(here("../knudson_0/rb_dat.txt"))

relationship <- c("Proband", "Identical", "twin", "Sib", "Father",
                  "Half-sib", "Paternal", "aunt", "great", "Mother",
                  "First", "cousin")

w <- read_tsv(here("../knudson_0/wilms_dat.txt"), col_names = TRUE) %>%
  separate(col = 1, into = as.character(1:9), sep = " ") %>%
  #group_by(1:n()) %>%
  mutate(sxM = apply(., 1, FUN = function(x) grep("^M$",x)) %>%
            replace_na(replace = 0) %>% unlist,
         sxF = apply(., 1, FUN = function(x) grep("^F$",x)) %>%
           replace_na(replace = 0) %>% unlist,
         sx = ifelse(sxM != 0, "M", ifelse(sxF != 0 , "F", "NS"))) %>%
  select(-sxF, -sxM)



use_data(k)
ggplot(k, aes(x=side, y= age_at_dx)) + geom_violin() + geom_jitter(alpha=0.5, width=0.1)

k2 <- k %>%
  arrange(side, -age_at_dx) %>%
  group_by(side) %>%
  mutate(idx_sum = 1 / length(side)) %>%
  mutate(prop_of_tot = cumsum(idx_sum))

ggplot(k2, aes(x=age_at_dx, y = prop_of_tot, group=side, color = side)) +
  geom_step() + geom_point() +
  #scale_y_log10() +
  #annotation_logticks(sides="l") +
  xlab("age in months") + ylab("Fract. of cases not diagnosed") +
  theme_classic()

#' Data used to formulate Knudson's 2-hit hypothesis
#'
#' @author My Name \email{blahblah@@roxygen.org}
#' @references \url{data_blah.com}
"k"
