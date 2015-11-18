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


// TS - When using sprockets, avoid including JS in the compilation file. Make a new file and require it here. Additionally, require_tree . is dangerous

$(document).ready(function() {
    $('.input-group input[required]').on('keyup change', function() {

      // TS - it's often ideal to not comma-ify your vars and instead declare `var` for each new variable
      // TS - unused $form var
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
        // TS - this If block doesn't do anything. Revise to !state
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
	  			$('html,body').scrollTop(0);
	  			$fake_flash.attr('class', 'alert alert-success fade in');
	  			$fake_flash.text('Successfully paid');

	  			var message;

          // TS - since resp.responseJSON.amount is being used multiple times, it's wise to cache the variable, i.e. var amount = resp.responseJSON.amount, and to just use amount
	  			if(resp.responseJSON.amount > 0) {
	  				message = "You are owed $" + resp.responseJSON.amount;
	  			}
	  			else if(resp.responseJSON.amount < 0) {
	  				message = "You owe $" + Math.abs(resp.responseJSON.amount) + " total.";
	  			}
	  			else {
	  				message = "You're all square!";
	  			}

	  			$('.owe-message').text(message);
	  		}

  			$('.welcome-message').before($fake_flash);

  			setTimeout(function() {
  				$('.alert').remove();
  			}, 3000);

        // TS - Should consider retooling your HTML and not using a table-based layout
  			$('table').each(function() {
  				if(!$(this).children('tbody').find('tr').length) {
  					$(this).prev().remove();
  					$(this).remove();
  				}
  			})
  		}
  	})
  })

});

// TS - calling $(function()... is unnecessary here. Everything in this wrapper could be declared within document ready
$(function() {

    $('#login-form-link').click(function(e) {
      // TS - use indentation
		$("#login-form").delay(100).fadeIn(100);
 		$("#signup-form").fadeOut(100);
		$('#signup-form-link').removeClass('active');
		$(this).addClass('active');

    // TS - declare e.preventDefault at the top of functions
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

// TS - calling $(function()... is unnecessary here. Everything in this wrapper could be declared within the first document ready
jQuery( function($) {
    $('a').tooltip();
});

// TS - redeclaration of document.ready Everything in this wrapper could be declared within the first instance
$(document).ready(function(){
  setTimeout(function(){
    $('#flash').remove();
  }, 3000);
 })
