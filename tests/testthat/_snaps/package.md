# is_pkgdown checks its inputs

    Code
      as_pkgdown(1)
    Condition
      Error in `as_pkgdown()`:
      ! `pkg` must be a single string, not the number 1.
    Code
      as_pkgdown(override = 1)
    Condition
      Error in `as_pkgdown()`:
      ! `override` must be a list, not the number 1.

# check_bootstrap_version() gives informative error otherwise

    Code
      check_bootstrap_version(1, pkg)
    Condition
      Error:
      ! template.bootstrap must be 3 or 5, not 1.
      i Edit _pkgdown.yml to fix the problem.

