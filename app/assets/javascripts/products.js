$(function() {
  var _visible = 4;
  var $pagers = $('#pager a');
  var _onBefore = function() {
    $(this).find('img').stop().fadeTo( 300, 1 );
    $pagers.removeClass( 'selected' );
  };

  $('#carousel').carouFredSel({
    items: _visible,
    width: '700',
    auto: false,
    scroll: {
      duration: 750
    },
    prev: {
      button: '#prev',
      items: 2,
      onBefore: _onBefore
    },
    next: {
      button: '#next',
      items: 2,
      onBefore: _onBefore
    },
  });

  $pagers.click(function( e ) {
    e.preventDefault();

    var group = $(this).attr( 'href' );
    var slides = $('#carousel div.' + group);
    var deviation = Math.floor( ( _visible - slides.length ) / 2 );
    if ( deviation < 0 ) {
      deviation = 0;
    }

    $('#carousel').trigger( 'slideTo', [ $('#' + group), -deviation ] );
    $('#carousel div img').stop().fadeTo( 300, 0.3 );
    slides.find('img').stop().fadeTo( 300, 1 );

    $(this).addClass( 'selected' );
});
});
