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
#
#hello <- function() {
#  print("Hello, world!")
#}
#
##Knudson's 2 hit hypothesis: Cited by 7590
#
#library(devtools)
#library(here)
#library(tidyverse)
#k <- read_tsv(here("../knudson_0/rb_dat.txt"))
#
#relationship <- c("Proband", "identical_twin", "Sib", "Father",
#                  "Half_sib", "Paternal_aunt", "Paternal_great_aunt", "Mother",
#                  "first_cousin")
#
#inRow <- function(df, rgx){
#  apply(df, 1, FUN = function(x) grep(rgx, x)) %>%
#    replace_na(replace = 0) %>% unlist
#}
#
#retColNmOfTrue <- function(df) {
#  #w[,11:ncol(w)]
#  df %>% apply(1, function(x) ifelse(x, names(x), NA)) %>%
#    apply(2, function(x) x[which(!is.na(x))])
#}
#
#grab_numeric <- function(df){
#  #grab the column with numeric values
#    df %>% apply(2, function(x) as.numeric(x)) %>%
#    apply( 1, function(x) x[!is.na(x)]) %>%
#    replace_na(-1) %>%
#    unlist %>% unname
#}
#
#w <- read_tsv(here("../knudson_0/wilms_dat.txt"), col_names = TRUE) %>%
#  separate(col = 1, into = as.character(1:9), sep = " ") %>%
#  mutate(sxM = inRow(df=.,rgx="^M$"),
#         sxF = inRow(df=.,rgx="^F$"),
#         sex = ifelse(sxM != 0, "M", ifelse(sxF != 0 , "F", "NS")))%>%
#  select(-sxF, -sxM) %>%
#  bind_cols(., data.frame(sapply(relationship,
#                                 function(x) inRow(df=., rgx=x)))) %>%
#  mutate_at(11:ncol(.), funs(. > 0)) %>%
#  mutate(relation = retColNmOfTrue(.[,11:ncol(.)] )) %>%
#  select_if(!names(.) %in% relationship) %>%
#  mutate(age = grab_numeric(.[,2:ncol(.)]),
#         atBirth = inRow(df = ., rgx = "Birth") > 0,
#         age = ifelse(atBirth, 0, age)) %>%
#  select(-atBirth) %>%
#  mutate(both_side = inRow(df=.,rgx="^B$"),
#         one_side = inRow(df=.,rgx="^U$"),
#         side = ifelse(both_side != 0, "B",
#                       ifelse(one_side != 0 , "U", "NS"))) %>%
#  select(-one_side, -both_side, ) %>%
#  mutate(reference = inRow(df = ., rgx = "^\\(") > 0,
#         reference = 3 + cumsum(reference)) %>%
#  rename(case=`1`) %>%
#  select(case, reference, sex, relation, age, side)
#
##save(w, file="data/w.rda")
#
#
#use_data(k)
#ggplot(k, aes(x=side, y= age_at_dx)) + geom_violin() + geom_jitter(alpha=0.5, width=0.1)
#
#k2 <- k %>%
#  arrange(side, -age_at_dx) %>%
#  group_by(side) %>%
#  mutate(idx_sum = 1 / length(side)) %>%
#  mutate(prop_of_tot = cumsum(idx_sum))
#
#ggplot(k2, aes(x=age_at_dx, y = prop_of_tot, group=side, color = side)) +
#  geom_step() + geom_point() +
#  #scale_y_log10() +
#  #annotation_logticks(sides="l") +
#  xlab("age in months") + ylab("Fract. of cases not diagnosed") +
#  theme_classic()

#' Retinoblastoma data used to formulate Knudson's 2-hit hypothesis
#'
#' This object contains the data from table 1 in the study  "Mutation and Cancer: Statistical Study of Retinoblastoma" 1971. PNAS. 68(4):820-823
#'
#' @format A tibble with 48 rows and 8 variables:
#' \describe{
#'   \item{case}{the case number}
#'   \item{hosp_numb}{the hospital id number of the patient}
#'   \item{sex}{the sex of the patient}
#'   \item{age_at_dx}{the age (in months) of the patient at diagnosis}
#'   \item{r_tum}{the number of tumors in the right eye. * if unknown.}
#'   \item{l_tum}{the number of tumors in the left eye. * if unknown.}
#'   \item{family_hx}{Is there a family history of retinoblastoma? If so, lists who was affected.}
#'   \item{side}{Was the retinoblastoma unilateral (unilat) or bilateral (bilat)}
#' }
#' @source \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC389051/}
"k"
