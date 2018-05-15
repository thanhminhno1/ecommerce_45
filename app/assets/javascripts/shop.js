$(document).on('turbolinks:load', function() {
  var token = $('meta[name="csrf-token"]').attr('content');

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
        $('.number-item').text(res.total+' Item');
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
        $('.number-item').text(res.total+' Item');
        new_total();
      }
    });
  })

  $('.quantity').change(function(){
    self = $(this);
    new_row_total($(this).parents('tr'));
    new_total();
    $.ajax({
      url: '/update_hard_cart',
      method: 'put',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', token)},
      data: {
        id_product: self.data("product"),
        quantity: self.val()
      },
      success: function(res){
        $('.number-item').text(res.total+' Item');
      }
     });
    $('.total').text(total);
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

  $('#btn_add_cart').click(function(event){
    event.preventDefault();
    self = $('.qty-product');
    if(self.val() > 0)
    {
      $.ajax({
        url: '/update_cart',
        method: 'put',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', token)},
        data: {
          id_product: self.data('product'),
          quantity: self.val()
        },
        success: function(res){
          $('.number-item').text(res.total+' Item');
        }
      });
    }
  });
});
