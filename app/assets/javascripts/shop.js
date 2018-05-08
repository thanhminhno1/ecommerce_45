$(document).on('turbolinks:load', function() {
  $('body').fadeIn(400);

  $('#myCarousel').carousel()
  $('#newProductCar').carousel()

/* Home page item price animation */
  $('.thumbnail').mouseenter(function() {
    $(this).children('.zoomTool').fadeIn();
  });

  $('.thumbnail').mouseleave(function() {
    $(this).children('.zoomTool').fadeOut();
  });

// Show/Hide Sticky 'Go to top' button
  $(window).scroll(function(){
    if($(this).scrollTop()>200){
      $('.gotop').fadeIn(200);
    }
    else{
      $('.gotop').fadeOut(200);
    }
  });

  $('.add_to_cart').click(function(event){
    event.preventDefault();
    self = $(this);
    $.ajax({
      url: self.attr('href'),
      method: 'get',
      success: function(res){
        $('.number-item').text(res.session.length+' Item');
        if(res.product == null)
        {
          var ask = window.confirm(I18n.t("client.confirm.product_not_exits"));
          if (ask) {
            window.location.href = '/';
          }
        }
      }
    });
  })

  $('.cart_remove').click(function(event){
    event.preventDefault();
    self = $(this);
    $.ajax({
      url: self.data('href'),
      method: 'get',
      success: function(res){
        self.parents('tr').remove();
        $('.number-item').text(res.session.length+' Item');
        new_total();
      }
    });
  })

  $('.quantity').change(function(){
    new_row_total($(this).parents('tr'));
    new_total();
  });

  function new_row_total(row) {
    total = parseInt(row.find('.quantity').val()) * parseInt(row.find('.price').text());
    row.find('.total_in_row').text(total);
  }

  function new_total() {
    total = 0;
    $('.total_in_row').each(function( index ) {
      total += parseInt($(this).text());
    });
    $('.total').text(total);
  }

  new_total();

  $('.gotop').click(function() {
    $('html, body').animate({ scrollTop: 0 }, 'slow');
    return false;
  });
});
