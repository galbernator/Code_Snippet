var $window = $(window),
      $stickyEl = $('#search'),
      elTop = $stickyEl.offset().top;

  $window.scroll(function() {
       $stickyEl.toggleClass('sticky', $window.scrollTop() > elTop);
   });
