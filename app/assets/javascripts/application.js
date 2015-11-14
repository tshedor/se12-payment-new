// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
    $('.input-group input[required]').on('keyup change', function() {
		var $form = $(this).closest('form'),
            $group = $(this).closest('.input-group'),
			$addon = $group.find('.input-group-addon'),
			$icon = $addon.find('span'),
			state = false;
            
    	if (!$group.data('validate')) {
			state = $(this).val() ? true : false;
		}else if ($group.data('validate') == "email") {
			state = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test($(this).val())
		}else if ($group.data('validate') == "length") {
			state = $(this).val().length >= $group.data('length') ? true : false;
		}

		if (state) {
				document.getElementById("email")
		}else{
				$addon.removeClass('success');
				$addon.addClass('danger');
				$icon.attr('class', 'glyphicon glyphicon-remove');
		}
        
	});
    
    $('.input-group input[required]').trigger('change');
    

  $('.js-update-paid').click(function(e) {
  	e.preventDefault();

  	var $this = $(this);
  	var payment_id = $this.attr('data-payment')

  	$.ajax({
  		url: '/paid',
  		method: 'POST',
  		dataType: 'json',
  		data: { id: payment_id },
  		complete: function(resp) {

  			var $fake_flash = $('<div />', { 
  				text: resp.responseJSON.msg,
  				class: 'alert alert-danger fade in'
  			});

  			if(resp.responseJSON.msg === true) {
	  			$('.payment-' + payment_id).remove();

	  			$fake_flash.attr('class', 'alert alert-success fade in');
	  			$fake_flash.text('Successfully paid');
	  		}

  			$('.welcome-message').before($fake_flash);

  			setTimeout(function() {
  				$('.alert').remove();
  			}, 3000);
  		}
  	})
  })
    
});

$(function() {

    $('#login-form-link').click(function(e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#signup-form").fadeOut(100);
		$('#signup-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	$('#signup-form-link').click(function(e) {
		$("#signup-form").delay(100).fadeIn(100);
 		$("#login-form").fadeOut(100);
		$('#login-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});

	if($('.errors').length) {
		var errors_text = $('.errors').text().trim();
		if(errors_text.indexOf('Invalid email/password combination') === -1) {
			$('#signup-form-link').click();
		}
	}

});

jQuery( function($) {
    $('a').tooltip();
});

$(document).ready(function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 3000);
 })
