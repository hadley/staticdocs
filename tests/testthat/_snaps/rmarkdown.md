# render_rmarkdown yields useful error

    Code
      render_rmarkdown(pkg, "assets/pandoc-fail.Rmd", "test.html")
    Output
      Reading 'assets/pandoc-fail.Rmd'
      -- RMarkdown error -------------------------------------------------------------
      File path-to-image.png not found in resource path
      Error : pandoc document conversion failed with error 99
      --------------------------------------------------------------------------------
    Error <rlang_error>
      Failed to render RMarkdown

# render_rmarkdown styles ANSI escapes

    <span class="co">#&gt; <span style="color: #BB0000;">X</span></span>

