jQuery.fn.autolink = function () {
	return this.each( function(){
		var re = /(((http|https|ftp):\/\/|www\.)[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/g;
		if ( '$2' == "www." ) {
		  $(this).html( $(this).html().replace(re, '<a href="$1">http://$1</a> ') );
		}
		else {
		  $(this).html( $(this).html().replace(re, '<a href="$1">$1</a> ') );
		}
	});
}