# pkgdown (development version)

## Bootstrap 5

* pkgdown can style your site with Bootstrap 5 (with help from @jayhesselberth,
  @apreshill, @cpsievert). Opt-in by setting `boostrap` version in your 
  `_pkgdown.yml`.
  
    ```yaml
    template:
      bootstrap: 5
    ```

* We reviewed site accessibility and made a number of improvements: (#782, #1553):

    * Larger default font, and more visible links.
    * Heading anchors use `aria-hidden` to reduce noise for screenreader users.
    * Improved `aria-labelledby` property for navbar dropdowns.
    * The default GitHub/GitLab links gain an `aria-label`; use of 
      `aria-labels` for other icons is now supported, and encouraged in the 
      docs
    * Syntax highlighting uses a new more
      [accessible colour scheme](https://apreshill.github.io/rmda11y/arrow.html), 
      designed by Alison Hill (#1536)
    * A skip link makes it easier to get directly to the page contents (#1827).

* In-line footnotes mean you can read asides next to the next they refer to. 

* Can use tabsets in articles, 
  [as in R Markdown](https://bookdown.org/yihui/rmarkdown-cookbook/html-tabs.html).
  (@JamesHWade, #1667).

* Other styling changes:
    
    * The active item in TOC is indicated with background color
    * If present a logo will appear on all pages near the header
    * Section anchors now appear on the right (making them usable on mobile phones) (#1782).
    * The TOC is scrollable independently on the main content. This makes it
      more useful on long pages with many headings (#1610).
    * The sidebar is shown on mobile
    * Function arguments and reference index (#1822) use definition list 
      (`<dl>`) rather than a table. This gives more room for long argument 
      names/lists of function and detailed descriptions, and displays better 
      on mobile.

* pkgdown can now translate all the text that it generates (#1446)- this means 
  that if you have a package where the docs are written in another language, you 
  can match all the pkgdown UI to provide a seamless experience to non-English
  speakers. Currently pkgdown includes translations for Spanish and French;
  if you're interested in adding translations for your language please file
  an issue and I'll help you get started.
  
    You can activate the translations by setting the `lang` field in 
    `_pkgdown.yaml` to `fr` (French) or `es` (Spanish):
   
    ```yaml
    lang: fr
    ```

## Local search

* pkgdown now supports local searching. It is enabled by default because no 
  set-up is needed for users to search pkgdown websites. (#1629, with help 
  from @gustavdelius in #1655 and @dieghernan @GregorDeCillia in #1770).

* pkgdown builds a more exhaustive sitemap.xml even for websites built with 
  Bootstrap 3. This might change Algolia results if you use Algolia for search 
  (#1629).

## Customisation

* New `vignette("customise")` documents all the ways you can 
  customise your site, including the new options described below (#1573).

* Sites can be easily themed either with bootswatch themes or by selectively
  override the "bslib" variables used to generate the CSS. pkgdown now uses scss 
  for its internal css tweaks. This means that you can now customise more parts 
  of the site using only `_pkgdown.yml`, without having to supply custom css.

* You can pick from a variety of built-in syntax highlighting themes (#1823).
  These control the colours (and background) of code in `<pre>` tags.
  
* Template packages can now provide a default configuration `_pkgdown.yml`, 
  stored in `inst/pkgdown/_pkgdown.yml`. This can be used to set (e.g.) author 
  definitions, Bootstrap version and variables, the sidebar, footer, navbar, 
  etc. Parameters supplied this way will be be overridden by a local 
  `_pkgdown.yml`, which is in turn overridden by `build_site(override =)` 
  (#1499).

* New `includes` parameters `in-header`, `before-body`, and `after-body` 
  make it easy to add arbitrary HTML to every page. Their content will be 
  placed at the end of the `<head>` tag, right below the opening `<body>` tag, 
  and before the closing tag `</body>` respectively (#1487). They match the 
  bookdown options `in_header`, `before_body` and `after_body`.

* Authors configuration is more flexible (#1516). Users can now:

    * Choose the roles used for filtering authors for the sidebar and footer.
    * Choose the text before authors in the footer.
    * Add text before and after the authors list in the sidebar.
    * Add text before and after the authors list of the authors page.

* Sidebar specification is more flexible (#1443, #1488, #1502). You can now:

    * Change the order of sidebar elements.
    * Add custom sidebar sections (title, text that can be Markdown or HTML).
    * Add a table of contents for the README.
    * Completely suppress the sidebar (even "Dev status")
    * Provide your own HTML for the navbar. 

* Navbar specification is more flexible: you can now exclude all default 
  components from the navbar (#1517). 

* The default navbar no longer includes a home icon - this took up precious
  horizontal space and wasn't very useful since there is already a link to the 
  home page immediately to its left (#1383).

* Footer specification is more flexible (#1502). You can now:
    
    * Change the placement of elements on the left and right.
    * Add text to the left and right (or even remove/replace default text)

## New features

* pkgdown now supports defining redirects. (#1259, @lorenzwalthert). 
  The syntax is the following, with old paths on the left, and new paths or 
  URLs on the right.

  ```yaml
  redirects:
    - ["articles/old-vignette-name.html", "articles/new-vignette-name.html"]
    - ["articles/another-old-vignette-name.html", "articles/new-vignette-name.html"]
    - ["articles/yet-another-old-vignette-name.html", "https://pkgdown.r-lib.org/dev"]
  ```

* Use HTML classes `pkgdown-devel` or `pkgdown-release` to declare that certain 
  content should appear only on the devel or release site. Use the class
  `pkgdown-hide` for content that should only appear only on GitHub/CRAN 
  (#1299).

## Code

* `build_reference()` now allows linking to topics from other packages (either 
  function names e.g. `rlang::is_installed` or topic names e.g. 
  `sass::font_face`). (#1664)

* Reference index section with `title: internal` is now silently dropped,
  allowing you to suppress warnings about topics that are not listed in the
  index (#1716).

* `build_reference()` will run `pkgdown/pre-reference.R` before and 
  `pkgdown/post-reference.R` after running examples. These allow you to
  do any setup or teardown operations you might need (#1602).

* Code blocks now get syntax highlighting according to their declared language 
  (e.g. `yaml`), if the documentation was built with roxygen2 7.1.2 or later 
  (#1690, #1692).

* Auto-generated links to inherited R6 methods now work correctly 
  whether internal (#1173, @vandenman) or external (#1476).

* New `pkgdown_print()` allows you to control how your objects are rendered in
  examples. It includes built-in handling for htmlwidgets and "browseable" HTML
  so pkgdown output now more closely resembles what you see in RStudio.
  Added extension points to make HTML widgets (and RGL in particular) work
  in rendered examples (@dmurdoch).

* Fix rendering of `\special{}` tags with complex contents (@klmr, #1744).

* `\value{}` and `\arguments{}` now do a better job of handling multiple 
  mingled items and text (#1479).

* The contents of `\value{}` are now shown immediately after `\arguments{}`.

* Autolinking no longer fails if a package contains duplicated Rd aliases.

* Automatic links to reference pages were generated incorrectly, and 
  self-links were generated, if the `\name{}` entry in the `*.Rd` file didn't 
  match the filename (@dmurdoch, #1586; #1676).
  
* The default "branch" for auto-linking is `HEAD`, which will work regardless
  of whether your default branch is called "main" or "master".

* You can globally set the `width` of code output (in reference and articles)
  with
    
    ```yaml
    code:
      width: 50
    ```

## Articles

* Article subtitle, author and date (specified in the YAML frontmatter) are now 
  correctly omitted from the article table of contents in the sidebar 
  (@maxheld83, #1428).

* Support for `as_is: true` and non-default output formats for vignettes/
  articles has been somewhat improved. Support is fundamentally limited due to
  the challenges of integrating HTML from output formats that pkgdown doesn't
  know about, but it should be a little more reliable and a little better
  documented (#1757, #1764).

* Articles now render output styles created by cli/crayon (#1556).

* When copy and pasting code blocks, lines containing output (e.g. `#>`)
  are automatically omitted (#1675).

* `build_articles()` no longer fails if you have a directory underneath 
  vignettes with a `.Rmd` extension (#1425).

* `build_articles()` now correctly handles links to images in `man/figures`
  (which have the form `../man/figures`) (#1472).

* `build_articles()` again sets the `theme` argument of the document format 
  to `NULL` when `as_is: true` but lets users override this via the `theme`
  argument of the output format.

* `build_articles()` and `build_home()` now warn if you have images that 
  won't rendered on the website because they're in unsupported directories 
  (#1810). Generally, it's only safe to refer to figures in `man/figures`
  and `vignettes`.

## HTML, CSS and JS

* pkgdown (in concert with downlit and roxygen2) is moving towards more 
  consistent HTML structure for syntax highlighting. The goal is to always have 
  a `<div>` with class `sourceCode` (and other classes as needed), which 
  contains one or more `<pre>`s that has class `sourceCode` and the language, 
  and each `<pre>` contains `<code>`. Something like this:

    ```html
    <div class='sourceCode'>
      <pre class='sourceCode r'><code>1 + 1</code></pre>
      <pre class='sourceCode r-out'><code>[1] 2</code></pre>
    </div>
    ```

* Styling for errors, warnings, and messages has been tweaked. Messages 
  are now displayed the same way as output, and warnings and errors are
  bolded, but not coloured. This is part of a suite of changes that aim to
  give package authors greater control over the appearance of messages, 
  warnings, and errors. 

* Long lines in code output are now wrapped, rather than requiring scrolling.
  This better matches `rmarkdown::html_document()` and what you see in the 
  console.
  
* New template option `trailingslash_redirect` that allows adding a script to 
  redirect `your-package-url.com` to `your-package-url.com/`. (#1439, @cderv, 
  @apreshill)

* `build_reference()` now runs examples with 
  `options(rlang_interactive = FALSE)` (ensuring non-interactive behaviour in 
  functions that use `rlang::is_interactive()`), 
  `options(cli.dynamic = FALSE)`, `Sys.setenv(RSTUDIO = NA)` 
  and `Sys.setLocale("LC_COLLATE", "C")` (#1693).

* External links now get the class `external-link`. This makes them easier to 
  style with CSS (#881, #1491).

* Duplicated section ids are now de-duplicated; this makes pkgdown work better with
  documentation for R6 classes.

* `pkgdown.css` now includes updated css styles from pandoc to support better
  reference list styling (#1469).

## News

* `build_news()` no longer breaks URLs with numeric fragments (@krassowski, #1456).

* `build_news()` recognises more styles of release heading (#1437).

* Heading links/IDs in the changelog are now permanent except from links 
  corresponding to the development version. They are built as the combination 
  of the heading slug and package version number. (@Bisaloo, #1015)

## Deployment

* `deploy_to_branch()` now calls `git remote set-branches` with `--add` to avoid
  overwriting the existing `remote.{remote}.fetch` value (@kyleam, #1382).

* `build_site_github_pages()` has been extracted out of `deploy_from_github()`
  to make it easier to decouple building and deployment, and so we can take
  advantage of standard deployment actions (#1756).

* Missing topics makes the build fail when the environment variable `CI` is set
  to `"true"` (@ThierryO, #1378).

* pkgdown's `deploy_to_branch()` now cleans out the website directory by default 
  (`clean = TRUE`). Revert to previous behaviour with `clean = FALSE` (#1394).

* You can override the `auto` development mode detected from the package 
  version by setting env var `PKGDOWN_DEV_MODE` to `release` or `devel`.
  This is useful if your package uses a different convention to indicate
  development and release versions (#1081).

## Other minor improvements and bug fixes 

* Links on the homepage no longer show the full url in the text.

* Make authors' non-ORCID comments from `DESCRIPTION` more usable as 
  bio/description of contributions: add a link to the authors page from the 
  sidebar if any author has a non-ORCID comment, and render non-ORCID 
  comments on the authors page. (#1516)

* Better handling for mix of citations with and without text version. Also
  escapes HTML in the text version (@bastistician, #1507).

* README badges in a single paragraph placed between `<!-- badges: end -->`and 
  `<!-- badges: end -->` comments are again detected (#1603). 

* The 404 page (default or from `.github/404.md`) is no longer built in the 
  development mode (see `?build_site`) as e.g. GitHub pages only uses the 
  `404.html` in the site root (#1622).

* All links on the 404 pages (navbar, scripts, CSS) are now absolute if there 
  is an URL in the configuration file (#1622).

* The version tooltip showed in the top navbar is now only set if you've 
  explicitly set the `development$mode` in `_pkgdown.yml` (#1768).

* Headings on the reference index page, and the arguments heading on the 
  reference pages, now get anchors (#1747).

* New `pkgdown_sitrep()` function reporting whether the pkgdown website URL is 
  stored in the pkgdown configuration and in `DESCRIPTION` (#1478).

* Use `autolink_bare_uris` for Pandoc above version 2.0 (@marcosmolla, #1618).

* pkgdown now recognizes GitLab URLs to the source repository and adds the corresponding icon
  to the navbar (#1493). It also properly supports [GitLab subgroups](https://docs.gitlab.com/ee/user/group/subgroups/)
  now (@salim-b, #1532).

* Links for GitHub Enterprise and GitLab Enterprise repositories are detected 
  by assuming such host address begin with `github.` or `gitlab.` 
  (@ijlyttle, #1452).

* Protect the rules drawn by the CLI (as for example, in `build_site()`) against
  very narrow terminal windows with small `getOption('width')`s 
  (@maxheld83, #1435).

* [Google Site Verification](https://support.google.com/webmasters/answer/9008080?hl=en) can now be configured for pkgdown sites.

* `build_rmarkdown_format` internally sets `html_document(anchor_sections = FALSE)` so to avoid needless dependencies (@atusy, #1426).

* Automatically link Jira issues by setting your project name(s) with 
`repo: jira_projects: [...]` and specifying a custom issue URL with
`repo: url: issue: ...` in `_pkgdown.yml` (@jonkeane, #1466).

# pkgdown 1.6.1

* The article index (used for autolinking vignettes across packages) 
  once again works (#1401).

# pkgdown 1.6.0

## Major changes

* pkgdown now uses the new [downlit](https://downlit.r-lib.org/) package for all 
  syntax highlighting and autolinking (in both reference topics and vignettes). 
  There should be very little change in behaviour because the code in downlit 
  was extracted from pkgdown, but this makes it easier to use pkgdown's nice 
  linking/highlighting in more places (#1234).

* pkgdown now uses the `ragg::agg_png()` device to generate example figures.
  This should be a little faster and produce higher quality output. Learn
  more at <https://ragg.r-lib.org> (#1320).

## Minor improvements and bug fixes

### Rd translation

* `\special{}` support inside `\usage{}` added to allow non-standard R usage
  syntax (@klmr, #1345).

* `#ifdef` and `#ifndef` are now supported; the "current" OS is hard coded to
  "unix" to ensure reproducible output regardless of where you build the 
  website (#1384).

* Nested `\subsection{}`s now generate appropriate heading levels 
  (h3, h4, h5 etc) (#1377), and get anchor links (#1389).

* `\preformatted{}` no longer double escapes its contents (#1311).

### Articles and vignettes

* `build_articles()` no longer sets the `theme` argument of the document format 
  to `NULL` when `as_is: true`. This should allow it to work with a wider
  range of output formats including `bookdown::html_vignette2()` and 
  friends (@GegznaV, #955, #1352).

* When `build_article()` fails, it gives the complete failure message (#1379).

* Markdown header attributes are now processed in all markdown files (@jonkeane, #1343)

### Auto-linking and syntax highlighting

* The branch used for source linking can be configured by setting 
  `repo: branch: branch_name` in `_pkgdown.yml` (@jonkeane, #1355):

    ```yaml
    repo:
      branch: main
    ```

* `autolink_html()` is (soft) deprecated. Please use 
  `downlit::downlit_html_path()` instead.

* Highlighting of empty expressions works once more (#1310).

* New `deploy$install_metadata` option in `_pkgdown.yml`. Setting it to
  `true` will store site metadata in the package itself, allowing offline
  access for packages that to autolink to the package's website 
  (@mstr3336, #1336).

### Other    

* You can now control the background colour of plots with the `figures.bg`
  option (it is transparent by default, and given a white background by
  css). See `?build_reference` for an example.

* HTML is automatically stripped from the page title (#1318).

* Suppressing CRAN dates in news file now actually works.

* All HTTP requests are now retried upon failure (@jameslamb, #1305).

* Setting `clean = TRUE` in `deploy_site_github()` removes old files from the 
  deployed site before building a new one (#1297).

# pkgdown 1.5.1

* Syntax highlighting works on Windows once more (#1282).

* pkgdown no longer fails if your `.Rd` files have duplicated `\aliases` 
  as were produced by an older version of roxygen2 (#1290).

* Rendering empty `.md` file now returns empty string (#1285).

* `build_articles_index()` is now exported to rapidly rebuild the index (#1281)

* `deploy_site_github()` now accepts a `host` argument to specify alternate 
  hosts (e.g., Github enterprise) (@dimagor, #1165) and once again works as 
  intended on Travis-CI (@jimhester, #1276).

# pkgdown 1.5.0

## New features

* The articles index page and navbar have been overhauled. There are two
  major new features in this release:

    * The articles index page now displays article `description`s,
      taken from YAML metadata belonging to each article. This lets you provide 
      more context about each article and describe why one might want to read 
      it (#1227).

    * The articles navbar is now also controlled by the `articles` section
      in `_pkgdown.yml`. The ordering of the sections, and articles within
      them, control the order of the articles in the navbar, and you can
      use the new `navbar` field to control whether or not each section
      appears in the navbar (#1101, #1146).

* The reference index now has two levels of heading hierarchy: `title` and
  `subtitle` (#327).

* Tables of contents in sidebars now use
  [bootstrap-toc](https://afeld.github.io/bootstrap-toc/); this considerably
  improves navigation for long articles and reference pages.

* You can now control the links to source files (in reference pages and 
  articles) and issues and users (in the NEWS) with new `repo$url` config
  option (#1238). This makes it easier to use pkgdown with GitHub enterprise,
  packages in subdirectories, and other source hosts (like bitbucket).

    ```yaml
    repo:
      url:
        home: https://github.com/r-lib/pkgdown/
        source: https://github.com/r-lib/pkgdown/blob/main/
        issue: https://github.com/r-lib/pkgdown/issues/
        user: https://github.com/
    ```

    The individual components (e.g. path, issue number, username) are pasted on 
    the end of these urls so they should have trailing `/`s.

    You don't need to set these links for GitLab, as pkgdown now detects 
    GitLab urls automatically (since they use the same structure as GitHub)
    (#1045). 

* There's much richer control over Open Graph and Twitter metadata for the 
  whote site and for individual articles. See new `vignette("metadata")` for 
  details (@gadenbuie, #936).

* New `deploy_to_branch()` function to build and deploy a site to a branch,
  defaulting to `gh-pages` for use with GitHub Pages. This is used in our 
  recommended GitHub action workflow for automatically building and deploying
  pkgdown sites for packages on GitHub (@jimhester, #1221).

* Updated JS libraries: jquery 3.3.1 -> 3.4.1; bootswatch 3.3.7 -> 3.4.0;
  bootstrap 3.3.7 -> bootstrap 3.4.1; docsearch 2.6.1 -> 2.6.3;
  fontawesome 5.11.1 -> 5.12.1; headroom.js 0.9.44 -> 0.11.0; 
  clipboard.js 2.0.4 -> 2.0.6 (@jayhesselberth).

## Auto-linking improvements

* Examples and Rmd now use exactly the same syntax highlighting strategy.

* In examples and Rmd, calls of the form `current_package::foo` now get
  a local link (#1262).

* `\preformatted{}` blocks are now highlighted and linked if they parse
  as R code (#1180).

* `library(pkgdown)` is now automatically linked to the reference index for 
  "pkgdown" not the documentation for `library()` (#1161).

* `help("topic")` is now automatically linked to the documentation for "topic",
  not to the documentation for `help()` (#1210)

## Minor improvements and bug fixes

### Articles

* `build_home()` no longer uses (unrendered) `README.Rmd` or `index.Rmd` if
  corresponding `.md` files are not found.

* `build_article()` failures now print more information to help you debug
  the problem (#952).

* The name of the vignette mapped to the "Get started" entry in the navbar 
  is now more flexible. You can use an article (e.g `articles/{pkgname}`) 
  and if your package has a `.` in its name you can replace it with `-` to 
  generate a valid article name (e.g. the get started vignette for 
  `pack.down` would be `pack-down`) (#1166).

### Deployment

* `deploy_to_branch()` now correctly captures the commit SHA on GitHub Actions
  (@coatless, #1252).

* `deploy_to_branch(github_pages = TRUE)` generates a `.nojekyll` to prevent
  jekyll ever executing (#1242).

* `CNAME` is no longer generated by `init_site()`, but is instead conditionally 
  by `deploy_to_branch()` when `github_pages = TRUE`. This is a better a fit 
  because the `CNAME` file is only needed by GitHub pages (#969).

* `deploy_site_github()` argument `repo_slug` has been deprecated and is no
  longer needed or used. (@jimhester, #1221)

### News 
See additional details in `?build_news`:

* You can optionally suppress the CRAN release dates added to the news 
  page (#1118).

* Multi-page news style gets a better yaml specification (the old style 
  will continue to work so no need to change existing YAML).

### Reference

* A topic named `index` will not longer clobber the reference index (#1110).

* Topic names/aliases on reference index are now escaped (#1216). 

* `build_reference()` gives better warnings if your `_pkgdown.yml` is
  constructed incorrectly (#1025).

* New `has_keyword()` topic selector for `reference`. `has_keyword("datasets")`
  is particularly useful for selecting all data documentation (#760).

* New `lacks_concepts()` can select topics that do not contain any of 
  a number of specified concepts. (@mikldk, #1232)

### Home, authors, and citation

* pkgdown now escapes html and linkifies links in comments in author info 
  from DESCRIPTION (@maelle, #1204)

* pkgdown now uses the ORCiD logo included in Font Awesome 5.11 instead of 
  querying it from members.orcid.org (@bisaloo, #1153)

* badges are now extracted from everything between `<!--badges: start-->`
  and `<!--badges: end-->`. They used to be extracted only if they were
  direct children of the first `<p>` after `<!--badges: start-->`.

* `build_home()` now looks for `pkgdown/index.md` in addition to the top-level 
  `index` or `README` files (@nteetor, #1031)

### Navbar

* pkgdown now formats the package version displayed in the navbar the same way
  as it has been specified in the DESCRIPTION file. In particular, version
  separators (e.g. `.` and `-`) are preserved. (#1170, @kevinushey)

* add support for navbar submenus: you can create submenus following the 
  convention established in [rstudio/rmarkdown#721](https://github.com/rstudio/rmarkdown/issues/721) (@ijlyttle, @wendtke, #1213)

### Other

* Updated JS libraries: jquery 3.3.1 -> 3.4.1; bootswatch 3.3.7 -> 3.4.0;
  bootstrap 3.3.7 -> bootstrap 3.4.1; docsearch 2.6.1 -> 2.6.3 
  (@jayhesselberth).

* Markdown conversion now explicitly allows markdown inside of HTML blocks;
  this was previously accidentally disabled (#1220).

* A timestamp for the last site build is reported in `pkgdown.yml` (#1122).

# pkgdown 1.4.1

* Don't install test package in user library (fixes CRAN failure).

# pkgdown 1.4.0

## New features

* build citation as specified by the `textVersion` argument of `citEntry` in the
  `CITATION` file (#1096, @yiluheihei)

* `build_site()`, `build_reference()` and `build_home()` gain a parameter 
  `devel` which controls whether you're in deployment or development mode.
  It generalises and replaces (with deprecation) the existing `document` 
  argument.

    Development mode is optimised for rapid iteration and is the default
    for `build_reference()`. It uses `pkgload::load_all()` to load code
    directly from disk in order.

    Deployment mode is slower, but guarantees correct results, and is the
    default for `build_site()`. It installs the package into a temporary
    library, and runs examples/articles in a new process.

* `build_reference()` no longer runs `devtools::document()` (#1079) and
  `build_home()` no longer re-builds `README.Rmd` or `index.Rmd`. This makes 
  the scope of responsibility of pkgdown more clear: it now only 
  creates/modifies files in `doc/`.

* `build_home()` now strips quotes from `Title` and `Description` fields 
  when generating page metadata. Additionally, you can now override the 
  defaults via the `title` and `description` fields in the `home` section of 
  `_pkgdown.yml` (#957, @maelle).

* `vignette("linking")` describes how pkgdown's automatic linking works, and
  how to ensure that cross-package links point to the right place.

## Bug fixes and minor improvements

### Rd translation

* `\examples{}` rendering has been completely overhauled so it now first 
  converts the entire mixed Rd-R block to R prior, and then evaluates the
  whole thing. This considerably improves the fidelity of the translation 
  at a small cost of no longer being able to remove `\donttest{}` and
  friends (#1087).

* `\item{}`s in `\describe{}` containing whitespace are translated correctly
  (#1117).

* `\dots` and `\ldots` are translated to `...` instead of the ellipsis,
  since they're often found in code (#1114).

* `\tabular{}` translation handles code better (@mitchelloharawild, #978).

* `\subsection{}` contents are now treated as paragraphs, not inline text 
  (#991).

* `\preformatted{}` blocks preserve important whitespace (#951).

### Front end

* Links to online documentation for functions in code chunks are no longer 
  displayed when printing (#1135, @bisaloo).

* Updated fontawesome to v5.7.1. fontawesome 5 [deprecated the `fa` prefix](https://fontawesome.com/how-to-use/on-the-web/setup/upgrading-from-version-4#changes).
  If you have used custom icons in your navbar, you'll should update them from
  (e.g.) `fa fa-home` to `fas fa-home`. Brands now have a separate prefix so
  `fa fa-github` becomes `fab fa-github` (#953).

* The navbar is now automatically hidden with 
  [headroom.js](https://wicky.nillia.ms/headroom.js/).

* The sticky behaviour of the navbar is now implemented in pure CSS instead of 
  relying a the 3rd party javascript library (#1016, @bisaloo)

* Favicons are now automatically built from a package logo (#949).

### Linking

* Infix operators (e.g., `%in%` and `%*%`) are now linked to their 
  documentation (#1082).

* Function names can now be included in headers without spurious auto-linking 
  (#948).

* Links to external documentation now point to [rdrr.io](https://rdrr.io) 
  (#998).

### Other

* News page recognises more version specifications (including the  
  "(development version)" now used by usethis) (#980).

* Subdirectories are supported for assets (#939, @ijlyttle).

* A default 404 page (`404.html`) is built, unless a custom `.github/404.md` 
  is provided (#947).

* `build_article()` now uses the raw vignette title as page `<title>` 
  and `og:title` (@maelle, #1037).

* `build_home()` now looks for license files spelled either as LICENSE or 
  LICENCE (#972).

* `build_home()` can find badges in paragraph coming after the comment 
  `<!-- badges: start -->` (#670, @gaborcsardi, @maelle).

* `build_home()` will add a community section to the sidebar if there is either 
  a code of  conduct (`.github/CODE_OF_CONDUCT.md`) or a contributing guide 
  (`.github/CONTRIBUTING.md`) (#1044, @maelle).

* `build_reference()` gains a `topics` argument which allows you to re-build
  only specified topics.

* `build_site(new_process = TRUE)` gains a timeout, 
  `options(pkgdown.timeout = 10)`, that can be used to prevent stalled 
  builds. 

* `deploy_site_github(install = FALSE)` makes it possible to opt out of 
  installation.

* `dev_mode()` now recognises `0.1.9000` as a development version of a package
  (this is an emerging standard we use for packages with backward incompatible
  changes) (#1101).

# pkgdown 1.3.0

* Restore accidentally deleted `build_logo()` function so that logos
  are once more copied to the website.

* Fix to `pkgdown.css` so page header has correct amount of top margin.

* `content-home.html` template is no longer used when the homepage
  is an `.Rmd` (Reverts #834. Fixes #927, #929)

* `deploy_site_github()` now passes parameters to `build_site()` 
  (@noamross, #922), and the documentation gives slightly better advice.

* Correct off-by-one error in navbar highlighting javascript; now no navbar
  is highlighted if none match the current path (#911).

* Tweaking of HTML table classes was fixed (@yonicd, #912)

* Restore accidentally removed `docsearch.css` file.

# pkgdown 1.2.0

## New features

* `deploy_site_github()` can be used from continuous integration systems
  (like travis) to automatically deploy your package website to GitHub Pages.
  See documentation for how to set up details (@jimhester).

* `build_favicon()` creates high resolution favicons from the package logo,
  and saves them in `pkgdown/`. They are created using the 
  <https://realfavicongenerator.net/> API, and are better suited for modern web 
  usage (e.g. retina display screens, desktop shortcuts, etc.). This also 
  removes the dependency on the magick package, making automated deployment
  a little easier (@bisaloo, #883).

* Users with limited internet connectivity can explicitly disable internet
  usage by pkgdown by setting `options(pkgdown.internet = FALSE)` (#774, #877).

## Improvements to Rd translation

* `rd2html()` is now exported to facilitate creation of translation reprexes.

* `\Sexpr{}` conversion supports multiple arguments, eliminating 
  `x must be a string or a R connection` errors when using `\doi{}` (#738).

* `\tabular{}` conversion better handles empty cells (#780).

* `\usage{}` now supports qualified functions eliminating  
  `Error in fun_info(x) : Unknown call: ::` errors (#795).

* Invalid tags now generate more informative errors (@BarkleyBG, #771, #891)

## Front end

* The default footer now displays the version of pkgdown used to build 
  the site (#876). 

* All third party resources are now fetched from a single CDN and are
  give a SRI hash (@bisaloo, #893).

* The navbar version now has class "version" so you can more easily control 
  its display (#680).

* The default css has been tweaked to ensure that icons are visible on all
  browsers (#852).

## Bug fixes and minor improvements

### Home page

* Can now build sites for older packages that don't have a `Authors@R` field 
  (#727).

* Remote urls ending in `.md` are no longer tweaked to end in `.html` (#763).

* Bug report link is only shown if there's a "BugReports" field (#855).

* `content-home.html` template is now used when the homepage is an `.Rmd` 
  (@goldingn, #787).

* A link to the source `inst/CITATION` was added to the authors page (#714).

### News

* Uses stricter regular expression when linking to GitHub authors (#902).

### Reference

* Unexported functions and test helpers are no longer loaded (#789).

* Selectors that do not match topics now generate a warning. If none of the 
  specified selectors have a match, no topics are selected (#728).

### Articles

* The display depth of vignette tables of contents can be configured by 
  setting `toc: depth` in `_pkgdown.yml` (#821):

  ```yaml
  toc:
    depth: 2
  ```

### Overall site

* `init_site()` now creates a CNAME file if one doesn't already exist and the
  site's metadata includes a `url` field.

* `build_site()` loses vestigal `mathjax` parameter. This didn't appear to do 
  anything and  no one could remember why it existed (#785).

* `build_site()` now uses colours even if `new_process = TRUE` (@jimhester).

# pkgdown 1.1.0

## New features

* `build_reference()` and `build_site()` get new `document` argument. When 
  `TRUE`, the default, will automatically run `devtools::document()` to 
  ensure that your documentation is up to date.

* `build_site()` gains a `new_process` argument, which defaults to `TRUE`.
  This will run pkgdown in a separate process, and is recommended practice
  because it improves reproducibility (#647).

* Improved display for icons: icons must be 30px and stored in top-level 
  `icons/` directory. They are embedded in a separate column of reference 
  index table, instead of being inside a comment (!) (#607).

## Front end

* Added a keyboard shortcut for searching. Press `shift` + `/` (`?`) to move 
  focus to the search bar (#642). 

* The Algolia logo is correctly shown in the search results (#673).

* Navbar active tab highlighting uses a superior approach (suggested by 
  @jcheng5) which should mean that the active page is correctly highlighted
  in all scenarios (#660).

* `pkgdown.js` is better isolated so it should still work even if you 
  load html widgets that import a different version of jquery (#655).

## Improvements to Rd translation

* `vignette()` calls that don't link to existing vignettes silently fail 
  to link instead of generating an uninformative error messages (#652). 
  Automatic linking works for re-exported objects that are not functions 
  (@gaborcsardi, #666).

* Empty `\section{}`s are ignored (#656). Previously, empty sections caused 
  error `Error in rep(TRUE, length(x) - 1)`.

* `\Sexpr{}` supports `results=text`, `results=Rd` and `results=hide` (#651).

* `\tabular{}` no longer requires a terminal `\cr` (#664, #645).

## Minor bug fixes and improvements

* Add `inst/pkgdown.yml` as a possible site configuration file so that packages 
  on CRAN can be built without needing the development version (#662).

* Default navbar template now uses site title, not package name (the package 
  name is the default title, so this will not affect most sites) (#654).

* You can suppress indexing by search engines by setting `noindex: true` 
  `pkgdown.yml` (#686)

    ```yaml
    template:
      params:
        noindex: true
    ```

* `build_article()` sets `IN_PKGDOWN` env var so `in_pkgdown()` works 
  (#650).

* `build_home()`: CITATION files with non-UTF-8 encodings (latin1) work
  correctly, instead of generating an error. For non-UTF-8 locales, ensure you 
  have e.g. `Encoding: latin1` in your `DESCRIPTION`; but best practice is to 
  re-enode your CITATION file to UTF-8 (#689).

* `build_home()`: Markdown files (e.g., `CODE_OF_CONDUCT.md`) stored in 
  `.github/` are copied and linked correctly (#682).

* `build_news()`: Multi-page changelogs (generated from `NEWS.md` with
  `news: one_page: false` in `_pkgdown.yml`) are rendered correctly.

* `build_reference()`: reference index shows infix functions (like `%+%`) as 
  `` `%+%` ``, not `` `%+%`() `` on  (#659).

# pkgdown 1.0.0

* Major refactoring of path handling. `build_` functions no longer take
  `path` or `depth` arguments. Instead, set the `destination` directory 
  at the top level of `pkgdown.yml`.

* Similarly, `build_news()` no longer takes a `one_page` argument;
  this should now be specified in the `_pkgdown.yml` instead. See the 
  documentation for an example.
