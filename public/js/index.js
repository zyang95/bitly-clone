$(document).ready(function(){
	$('.submit_button').click(function () {
		var $link = $('.long_link');	
		$.post('urls', { long_link: $link.val()}, function (data, status) {
			var newdata = `<p class= 'short_link_data'>`+ data +`</p>`+ `<p>
			  <button onclick="copyToClipboard('.short_link_data')" style="vertical-align:top;">Copy Textarea</button>
			</p>`
			$('.panel').html(newdata);

			$('.panel').slideDown('slow');
			// copyTextareaBtn.addEventListener('click', function(event) {
			//   console.log($('.short_link_data'));
			//   // copyTextarea.select();

			//   try {
			//     var successful = document.execCommand('copy');
			//     var msg = successful ? 'successful' : 'unsuccessful';
			//     console.log('Copying text command was ' + msg);
			//   } catch (err) {
			//     console.log('Oops, unable to copy');
			//   }
			// });
			
	
			// var copy = document.querySelector('.short_link_data')
			// $('.js-textareacopybtn').click(function() {
	
			// 	console.log(copy);
			// 	// .select(
			// 	// document.execCommand('copy'))
			// 	//console.log(copy).text();	
			// });

		});
	});

});

function copyToClipboard(element) {
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();
}

