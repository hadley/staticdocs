/* http://gregfranko.com/blog/jquery-best-practices/ */
(function($) {
  $(function() {

    $('nav.navbar').headroom();

    $('body').scrollspy({
      target: '#sidebar',
      offset: 60
    });

    Toc.init({
      $nav: $("#toc"),
      $scope: $("h2, h3, h4, h5, h6")
    });

    // Activate popovers
    $('[data-toggle="popover"]').popover({
      container: 'body',
      html: true,
      trigger: 'focus',
      placement: "top",
      sanitize: false,
    });

    $('[data-toggle="tooltip"]').tooltip();

  /* Clipboard --------------------------*/

  function changeTooltipMessage(element, msg) {
    var tooltipOriginalTitle=element.getAttribute('data-original-title');
    element.setAttribute('data-original-title', msg);
    $(element).tooltip('show');
    element.setAttribute('data-original-title', tooltipOriginalTitle);
  }

  if(ClipboardJS.isSupported()) {
    $(document).ready(function() {
      var copyButton = "<button type='button' class='btn btn-primary btn-copy-ex' title='Copy to clipboard' aria-label='Copy to clipboard' data-toggle='tooltip' data-placement='left' data-trigger='hover' data-clipboard-copy><i class='fa fa-copy'></i></button>";

      $(".examples, div.sourceCode").addClass("hasCopyButton");

      // Insert copy buttons:
      $(copyButton).prependTo(".hasCopyButton");

      // Initialize tooltips:
      $('.btn-copy-ex').tooltip({container: 'body'});

      // Initialize clipboard:
      var clipboard = new ClipboardJS('[data-clipboard-copy]', {
        text: function(trigger) {
          return trigger.parentNode.textContent;
        }
      });

      clipboard.on('success', function(e) {
        changeTooltipMessage(e.trigger, 'Copied!');
        e.clearSelection();
      });

      clipboard.on('error', function() {
        changeTooltipMessage(e.trigger,'Press Ctrl+C or Command+C to copy');
      });

    });
  }

    /* Search marking --------------------------*/
    var url = new URL(window.location.href);
    var toMark = url.searchParams.get("q");
    var mark = new Mark("div.col-md-9");
    if (toMark) {
      mark.mark(toMark, {
        accuracy: {
          value: "complementary",
          limiters: [",", ".", ":", "/"],
        }
      });
    }

  /* Search --------------------------*/
    // Initialise search index on focus
  var fuse;
  $("#search-input").focus(async function(e) {
    if (fuse) {
      return;
    }

    $(e.target).addClass("loading");
    var response = await fetch($("#search-input").data("search-index"));
    var data = await response.json();

    var options = {
      keys: ["heading", "text", "code"],
      ignoreLocation: true,
      threshold: 0.1,
      includeMatches: true,
      includeScore: true,
    };
    fuse = new Fuse(data, options);

    $(e.target).removeClass("loading");
  });

  // Use algolia autocomplete
  var options = {
    autoselect: true,
    debug: true,
    hint: false,
    minLength: 2,
  };
  var q;
async function searchFuse(query, callback) {
  await fuse;

  var items;
  if (!fuse) {
    items = [];
  } else {
    q = query;
    var results = fuse.search(query, { limit: 20 });
    items = results
      .filter((x) => x.score <= 0.75)
      .map((x) => x.item);
  }
  console.log(results);
  callback(items);
}
  $("#search-input").autocomplete(options, [
    {
      name: "content",
      source: searchFuse,
      templates: {
        suggestion: (s) => {
          if (s.title == s.heading) {
            return `<div class="search-details">${s.title}</div>`;
          } else {
            return `${s.title}	<br><div class="search-details"> ${s.heading}</div>`;
          }
        },
      },
    },
  ]).on('autocomplete:selected', function(event, s) {
    window.location.href = s.path + "?q=" + q + "#" + s.id;
  });
  });
})(window.jQuery || window.$)


