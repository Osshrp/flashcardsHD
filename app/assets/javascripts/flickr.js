

jQuery(function($)	{
	$(function() {
	  $('a#show_div').click(function(event){
	    event.preventDefault();
	    $('div#hidden').fadeToggle(400);
	  });
	});


  $(function() {
     $('#search_btn').click(function(event) {
       event.preventDefault();
       var elem = document.getElementById('card_photo_search_string').value;
       var card_id = document.getElementById('card_id').value;
       $.ajax({
        method: 'POST',
        url: '/search-photo',
        data: { card: { photo: { search_string: elem } } }
      })
      .done(function( data ) {
        ahoy.track("images loaded from flickr");
        $('#flickr-photo').html(data);
      });
    });
  });

  $(function() {
    $(document).on('click', 'li a img', function(event) {
      event.preventDefault();
      $('#card_remote_image_url').val(event.target.src);
      $('#flickr-photo').fadeToggle(400);
    });
  });
});
