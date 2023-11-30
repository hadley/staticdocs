# parse failures include file name

    Code
      build_reference(pkg)
    Message
      Writing reference/index.html
      Reading man/f.Rd
    Condition
      Error in `purrr::map()`:
      i In index: 1.
      i With name: f.Rd.
      Caused by error in `.f()`:
      ! Failed to parse Rd in 'f.Rd'
      Caused by error in `purrr::map()`:
      i In index: 4.
      Caused by error:
      ! Failed to parse tag "\\url{}".
      i Check for empty \url{} tags.

# .Rd without usage doesn't get Usage section

    Code
      build_reference(pkg, topics = "e")
    Message
      Writing reference/index.html
      Reading man/e.Rd
      Writing reference/e.html

---

    Code
      build_reference(pkg, topics = "e")
    Message
      Writing reference/index.html
      Reading man/e.Rd
      Writing reference/e.html

# pkgdown html dependencies are suppressed from examples in references

    Code
      build_reference(pkg, topics = "a")
    Message
      Writing reference/index.html
      Reading man/a.Rd
      Writing reference/a.html

