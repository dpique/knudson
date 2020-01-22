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
