$(document).ready(function(){
	$('.submit_button').click(function () {
		var $link = $('.long_link');	
		$.post('urls', { long_link: $('.long_link').val()}, function (data, status) {
					var newdata = `<p class= 'short_link_data'>`+ data +`</p>`+ `<p>
					  <button class="js-textareacopybtn" style="vertical-align:top;">Copy Textarea</button>
					</p>`
			$('.panel').html(newdata);

			$('.panel').slideDown('slow');
		});
	});
});

var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

copyTextareaBtn.addEventListener('click', function(event) {
  var copyTextarea = document.querySelector('.short_link_data');
  copyTextarea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }
});