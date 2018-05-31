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
        update_number_cart(res.total);
        if(res.product == null)
        {
          var ask = window.confirm(I18n.t("client.confirm.product_not_exits"));
          if (ask) {
            window.location.href = '/';
          }
        }
      },
      statusCode: {
        400: function(){
          not_enough_notify();
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
        update_number_cart(res.total);
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
        update_number_cart(res.total);
      },
      statusCode: {
        400: function(){
          not_enough_notify();
        }
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

  function update_number_cart(total) {
    if(total == null){
      $('.number-item').text(I18n.t('layout.home.item'));
    }else{
      $('.number-item').text(total + I18n.t('layout.home.item'));
    }
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
          update_number_cart(res.total);
        },
        statusCode: {
          400: function(){
            not_enough_notify();
          }
        }
      });
    }
  });

  function not_enough_notify() {
    $('.top-right').notify({
      message: { text: I18n.t('controller.order.not_enough_quantity') }
    }).show();
  }

  $('.fb-comments').attr('data-href', window.location.href );

  $('.fb-share-button').attr('data-href', window.location.href );

  $('#order_status').change(function(){
    $(this).parents('form').submit();
  });

  function checkfile(sender) {
    var validExts = new Array('.xlsx', '.xls');
    var fileExt = sender.val();
    fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
    if (validExts.indexOf(fileExt) < 0) {
      alert(I18n.t('client.confirm.invalid_file_excel') + validExts.toString());
      sender.val('');
      return false;
    }
    else return true;
  }

  $('#file').change(function(){
    checkfile($(this));
  })

  $('.datepicker').datepicker({
  });

  $('.yearpicker').datepicker({
    format: 'yyyy',
    viewMode: 'years',
    minViewMode: 'years'
  });

  $('.monthpicker').datepicker({
    format: 'mm/yyyy',
    viewMode: 'months',
    minViewMode: 'months'
  });

  $('input[name="type"]').change(function(){
    $(this).parents('.form-horizontal').find('.form-control').attr('disabled', true);
    $(this).parents('.form-group').find('.form-control').removeAttr('disabled');
  });

  $('#from_date, #to_date').change(function(){
    if($('#from_date').val() != '' && $('#to_date').val() != '' && $('#from_date').val() > $('#to_date').val())
    {
      alert(I18n.t('client.confirm.invalid_date_range'));
      $('#from_date').val($('#to_date').val());
    }
  });

  $('.quantity_in_cart').change(function(){
    if($(this).val() > $(this).attr('max'))
    {
      $(this).val($(this).attr('max'));
    }
  })

  $('#search_button').click(function(){
    $('#clone').html('');
    $('#clone').append($('.clone-item').clone().attr('type', 'hidden'));
    $('#product_search').submit();
  })
});
