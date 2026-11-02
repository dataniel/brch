#' brch: Danish industry codes, DB07 and DB25
#'
#' Statistics Denmark's industry classification (Dansk Branchekode) changed
#' from DB07 to DB25, and register data carries both, in several formats.
#' brch formats the codes, labels them, tells the two classifications
#' apart, and converts between them with Statistics Denmark's keys. The
#' keys and labels are bundled, so nothing goes online. See
#' `vignette("brch")`.
#'
#' ## Where to start
#'
#' * [inspect_db()]: which classification a code belongs to, with both
#'   labels.
#' * [convert_db07_to_db25()] and [convert_db25_to_db07()]: strict or
#'   simplified conversion.
#' * [db_label()]: the label of a code, for an explicit version.
#' * [format_db07()]: dotted or compact codes from mixed input.
#'
#' ## Why a package of its own
#'
#' These functions started in the daos package. They moved here, unchanged,
#' because they share bundled data from Statistics Denmark that the general
#' utilities in daos do not need. brch depends only on tibble, and
#' daos does not depend on it, or it on daos. The data is rebuilt with
#' `data-raw/db07_db25.R` in the source repository.
#'
#' @keywords internal
"_PACKAGE"
