# Getting started with brch

Register data carries Danish industry codes from two classifications,
DB07 and DB25, and in more than one format. brch handles the format, the
labels, which classification a code belongs to, and the conversion
between them. Keys and labels from Statistics Denmark are bundled, so no
internet connection is needed.

## `format_db07()`: choose the format of DB07 industry codes

DB07 industry codes appear both as `011100` and `01.11.00` depending on
the source.
[`format_db07()`](https://dataniel.github.io/brch/reference/format_db07.md)
automatically handles mixed input with dots, whitespace, or digits only.
Choose `"dotted"` (the default) or `"compact"` output without specifying
the input format. Any aggregation level works:

``` r
format_db07(c("011100", "01.1100", "0111", "011"))
#> [1] "01.11.00" "01.11.00" "01.11"    "01.1"
format_db07(c("011100", "01.11.00", "01 11 00"), format = "compact")
#> [1] "011100" "011100" "011100"
```

[`format_db07()`](https://dataniel.github.io/brch/reference/format_db07.md)
never invents digits: a code that lost its leading zero in Excel is
ambiguous (`111` could be group `11.1` or class `01.11`), so keep
industry codes as character columns.

## `db_label()`: add Danish industry labels

Use
[`db_label()`](https://dataniel.github.io/brch/reference/db_label.md) to
add a label column from a DB code. Always specify `version = "DB07"` or
`version = "DB25"`; identical codes can have different meanings in the
two classifications.

``` r
df <- data.frame(dbkode = c("011200", "01.49.10", NA))
df |> dplyr::mutate(branche_label = db_label(dbkode, version = "DB07"))
#>     dbkode   branche_label
#> 1   011200 Dyrkning af ris
#> 2 01.49.10        Kenneler
#> 3     <NA>            <NA>
db_label(c("A", "01", "01.1", "01.11"), version = "DB25")
#> [1] "LANDBRUG, JAGT, SKOVBRUG OG FISKERI"                              
#> [2] "Plante- og husdyravl, jagt og serviceydelser i forbindelse hermed"
#> [3] "Dyrkning af etårige afgrøder"                                     
#> [4] "Dyrkning af korn (undtagen ris), bælgfrugter og olieholdige frø"
```

Labels come from the bundled DST tables and work offline. Input can
contain dots or whitespace. Unknown codes return `NA` with a warning;
missing values stay missing. Keep leading zeroes in character codes.

## Convert industry codes between DB07 and DB25

For mixed data, inspect the source codes before converting:

``` r
inspect_db(c("014910", "014800", "253000", "011200", NA))
#> # A tibble: 5 × 5
#>   input  code   status    label_db07                                  label_db25
#>   <chr>  <chr>  <chr>     <chr>                                       <chr>     
#> 1 014910 014910 db07_only Kenneler                                    NA        
#> 2 014800 014800 db25_only NA                                          Avl af an…
#> 3 253000 253000 both      Fremstilling af dampkedler undtagen centra… Fremstill…
#> 4 011200 011200 both      Dyrkning af ris                             Dyrkning …
#> 5 NA     NA     missing   NA                                          NA
```

`db07_only` and `db25_only` indicate membership in just one
classification. `both` means the version cannot be determined from the
code alone: `253000` has different meanings in DB07 and DB25. Both
labels are returned for review. Identical labels also leave the version
unresolved. Use source metadata and the original industry text and time
context to investigate these rows. The inspection supports full
six-digit codes only.

[`convert_db07_to_db25()`](https://dataniel.github.io/brch/reference/convert_db07_to_db25.md)
and
[`convert_db25_to_db07()`](https://dataniel.github.io/brch/reference/convert_db07_to_db25.md)
use bundled keys from [Statistics
Denmark](https://www.dst.dk/da/Statistik/dokumentation/dansk-branchekode-er-gaeldende)
(source page updated 26 February 2026), so no internet connection is
needed. Both accept full six-digit codes with or without dots and
whitespace:

``` r
convert_db07_to_db25(c("011100", "01.49.10", NA))
#> [1] "01.11.00" "01.48.00" NA
convert_db25_to_db07("25.30.00", format = "compact")
#> [1] "254000"
```

By default, a code with multiple possible destinations returns `NA` with
a warning. To choose DST’s simplified mapping explicitly:

``` r
convert_db07_to_db25("01.19.00", method = "simple")
#> [1] "01.19.00"
convert_db25_to_db07("01.48.00", method = "simple")
#> [1] "01.49.10"
```

The simplified matrices are specific to each direction and use numbers
of units, not economic activity. They are approximate and should not be
used as weights to distribute turnover. A round trip need not recover
the original code. Invalid lengths and unknown codes return `NA` with a
warning; missing values remain missing. Leading zeroes are not guessed.
