# brch

[![R-CMD-check](https://github.com/dataniel/brch/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dataniel/brch/actions/workflows/R-CMD-check.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

Danish industry codes (Dansk Branchekode), DB07 and DB25: format them,
label them, tell the two classifications apart, and convert between them
with Statistics Denmark's keys, bundled and offline.

The functions moved here unchanged from
[daos](https://github.com/dataniel/daos). brch depends only on tibble.

## Installation

```r
pak::pak("dataniel/brch")
```

## What it looks like

```r
library(brch)

inspect_db(firms$branche)                     # DB07, DB25 or both?

firms |>
  dplyr::mutate(db25 = convert_db07_to_db25(branche),
                branche_tekst = db_label(db25, version = "DB25"))
```

## Functions

| Function | Description |
|----------|-------------|
| `format_db07()` | Automatically handle mixed DB07 input; choose dotted (`01.11.00`) or compact (`011100`) output |
| `db_label()` | Look up Danish industry labels with an explicit DB07 or DB25 version |
| `inspect_db()` | Inspect mixed full DB07/DB25 codes; flag shared codes and show both labels |
| `convert_db07_to_db25()` / `convert_db25_to_db07()` | Convert full industry codes using DST's bundled keys; strict or simplified mapping |
