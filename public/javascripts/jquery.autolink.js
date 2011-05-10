(function( $ ){
  $.fn.autolink = function() {
    this.each( function() {
      var re, matches;
  		re = /(((http|https|ftp):\/\/|www\.)[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/g;
  		$(this).html( $(this).html().replace(re, function(link) {
  		  var href;

  		  if ( /^www./.test(link) ) {
  		    href = 'http://' + link;
  		  }
  		  else {
  		    href = link;
  		  }

  		  return '<a href="' + href + '">' + link + '</a> ';
  		}));
    });
  };
})( jQuery );