# can generate three types of row

    Code
      data_reference_index(pkg)
    Output
      pagetitle: Function reference
      rows:
      - title: A
        slug: a
        desc: ~
        is_internal: no
      - subtitle: B
        slug: b
        desc: ~
        is_internal: no
      - topics:
        - path: a.html
          title: A
          aliases: a()
          icon: ~
        - path: b.html
          title: B
          aliases: b()
          icon: ~
        - path: c.html
          title: C
          aliases: c()
          icon: ~
        - path: e.html
          title: E
          aliases: e
          icon: ~
        - path: help.html
          title: D
          aliases: '`?`()'
          icon: ~
        names:
        - a
        - b
        - c
        - e
        - '?'
        row_has_icons: no
        is_internal: no
      has_icons: no
      

# warns if missing topics

    Code
      data_reference_index(pkg)
    Condition
      Error in `check_missing_topics()`:
      ! All topics must be included in reference index
      x Missing topics: c, e, ?
      i Either add to _pkgdown.yml or use @keywords internal

# errors well when a content entry is empty

    i In index: 1.
    Caused by error in `check_all_characters()`:
    ! Item 2 in section 1 in reference is empty.
    i Either delete the empty line or add a function name in '_pkgdown.yml'.

# errors well when a content entry is not a character [plain]

    Code
      build_reference_index(pkg)
    Condition
      Error in `map2()`:
      i In index: 1.
      Caused by error in `check_all_characters()`:
      ! Item 2 in section 1 in reference must be a character.
      i You might need to add '' around e.g. - 'N' or - 'off' in '_pkgdown.yml'.

# errors well when a content entry is not a character [ansi]

    Code
      build_reference_index(pkg)
    Condition
      [1m[33mError[39m in `map2()`:[22m
      [1m[22m[36mi[39m In index: 1.
      [1mCaused by error in `check_all_characters()`:[22m
      [1m[22m[33m![39m Item [32m2[39m in section 1 in [32mreference[39m must be a character.
      [36mi[39m You might need to add '' around e.g. - 'N' or - 'off' in [34m_pkgdown.yml[39m.

# errors well when a content entry is not a character [unicode]

    Code
      build_reference_index(pkg)
    Condition
      Error in `map2()`:
      ℹ In index: 1.
      Caused by error in `check_all_characters()`:
      ! Item 2 in section 1 in reference must be a character.
      ℹ You might need to add '' around e.g. - 'N' or - 'off' in '_pkgdown.yml'.

# errors well when a content entry is not a character [fancy]

    Code
      build_reference_index(pkg)
    Condition
      [1m[33mError[39m in `map2()`:[22m
      [1m[22m[36mℹ[39m In index: 1.
      [1mCaused by error in `check_all_characters()`:[22m
      [1m[22m[33m![39m Item [32m2[39m in section 1 in [32mreference[39m must be a character.
      [36mℹ[39m You might need to add '' around e.g. - 'N' or - 'off' in [34m_pkgdown.yml[39m.

# errors well when a content entry refers to a not installed package [plain]

    Code
      build_reference_index(pkg)
    Condition
      Error in `map2()`:
      i In index: 1.
      Caused by error in `purrr::map2()`:
      i In index: 1.
      Caused by error in `.f()`:
      ! The package "notapackage" is required as it's used in the reference index.

# errors well when a content entry refers to a not installed package [ansi]

    Code
      build_reference_index(pkg)
    Condition
      [1m[33mError[39m in `map2()`:[22m
      [1m[22m[36mi[39m In index: 1.
      [1mCaused by error in `purrr::map2()`:[22m
      [1m[22m[36mi[39m In index: 1.
      [1mCaused by error in `.f()`:[22m
      [1m[22m[33m![39m The package "notapackage" is required as it's used in the reference index.

# errors well when a content entry refers to a not installed package [unicode]

    Code
      build_reference_index(pkg)
    Condition
      Error in `map2()`:
      ℹ In index: 1.
      Caused by error in `purrr::map2()`:
      ℹ In index: 1.
      Caused by error in `.f()`:
      ! The package "notapackage" is required as it's used in the reference index.

# errors well when a content entry refers to a not installed package [fancy]

    Code
      build_reference_index(pkg)
    Condition
      [1m[33mError[39m in `map2()`:[22m
      [1m[22m[36mℹ[39m In index: 1.
      [1mCaused by error in `purrr::map2()`:[22m
      [1m[22m[36mℹ[39m In index: 1.
      [1mCaused by error in `.f()`:[22m
      [1m[22m[33m![39m The package "notapackage" is required as it's used in the reference index.

# errors well when a content entry refers to a non existing function [plain]

    Code
      build_reference_index(pkg)
    Condition
      Error in `map2()`:
      i In index: 1.
      Caused by error in `purrr::map2()`:
      i In index: 1.
      Caused by error in `.f()`:
      ! Could not find documentation for `rlang::lala()`.

# errors well when a content entry refers to a non existing function [ansi]

    Code
      build_reference_index(pkg)
    Condition
      [1m[33mError[39m in `map2()`:[22m
      [1m[22m[36mi[39m In index: 1.
      [1mCaused by error in `purrr::map2()`:[22m
      [1m[22m[36mi[39m In index: 1.
      [1mCaused by error in `.f()`:[22m
      [1m[22m[33m![39m Could not find documentation for `rlang::lala()`.

# errors well when a content entry refers to a non existing function [unicode]

    Code
      build_reference_index(pkg)
    Condition
      Error in `map2()`:
      ℹ In index: 1.
      Caused by error in `purrr::map2()`:
      ℹ In index: 1.
      Caused by error in `.f()`:
      ! Could not find documentation for `rlang::lala()`.

# errors well when a content entry refers to a non existing function [fancy]

    Code
      build_reference_index(pkg)
    Condition
      [1m[33mError[39m in `map2()`:[22m
      [1m[22m[36mℹ[39m In index: 1.
      [1mCaused by error in `purrr::map2()`:[22m
      [1m[22m[36mℹ[39m In index: 1.
      [1mCaused by error in `.f()`:[22m
      [1m[22m[33m![39m Could not find documentation for `rlang::lala()`.

# can use a topic from another package

    Code
      data_reference_index(pkg)
    Output
      pagetitle: Function reference
      rows:
      - title: bla
        slug: bla
        desc: ~
        is_internal: no
      - topics:
        - path: a.html
          title: A
          aliases: a()
          icon: ~
        - path: b.html
          title: B
          aliases: b()
          icon: ~
        - path: c.html
          title: C
          aliases: c()
          icon: ~
        - path: e.html
          title: E
          aliases: e
          icon: ~
        - path: help.html
          title: D
          aliases: '`?`()'
          icon: ~
        - path: https://rlang.r-lib.org/reference/is_installed.html
          title: Are packages installed in any of the libraries? (from rlang)
          aliases:
          - is_installed()
          - check_installed()
          icon: ~
        - path: https://rdrr.io/pkg/bslib/man/bs_bundle.html
          title: Add low-level theming customizations (from bslib)
          aliases:
          - bs_add_variables()
          - bs_add_rules()
          - bs_add_functions()
          - bs_add_mixins()
          - bs_bundle()
          icon: ~
        names:
        - a
        - b
        - c
        - e
        - '?'
        - rlang::is_installed()
        - bslib::bs_add_rules
        row_has_icons: no
        is_internal: no
      has_icons: no
      

