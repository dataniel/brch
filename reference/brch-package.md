# brch: Danish industry codes, DB07 and DB25

Statistics Denmark's industry classification (Dansk Branchekode) changed
from DB07 to DB25, and register data carries both, in several formats.
brch formats the codes, labels them, tells the two classifications
apart, and converts between them with Statistics Denmark's keys. The
keys and labels are bundled, so nothing goes online. See
[`vignette("brch")`](https://dataniel.github.io/brch/articles/brch.md).

## Details

### Where to start

- [`inspect_db()`](https://dataniel.github.io/brch/reference/inspect_db.md):
  which classification a code belongs to, with both labels.

- [`convert_db07_to_db25()`](https://dataniel.github.io/brch/reference/convert_db07_to_db25.md)
  and
  [`convert_db25_to_db07()`](https://dataniel.github.io/brch/reference/convert_db07_to_db25.md):
  strict or simplified conversion.

- [`db_label()`](https://dataniel.github.io/brch/reference/db_label.md):
  the label of a code, for an explicit version.

- [`format_db07()`](https://dataniel.github.io/brch/reference/format_db07.md):
  dotted or compact codes from mixed input.

### Why a package of its own

These functions started in the daos package. They moved here, unchanged,
because they share bundled data from Statistics Denmark that the general
utilities in daos do not need. brch depends only on tibble, and daos
does not depend on it, or it on daos. The data is rebuilt with
`data-raw/db07_db25.R` in the source repository.

## See also

Useful links:

- <https://dataniel.github.io/brch>

- <https://github.com/dataniel/brch>

- Report bugs at <https://github.com/dataniel/brch/issues>

## Author

**Maintainer**: Daniel Madsen <danielmadsen@live.dk>

Authors:

- Daniel Madsen <danielmadsen@live.dk>
