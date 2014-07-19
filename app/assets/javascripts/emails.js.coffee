# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	#Click fires up a modal
	$('.reply-modal').click (e) ->
		if (e.ctrlKey||e.metaKey)&&e.which==1
			return true
		else
			e.preventDefault();
			$("#replyModal").modal('show')

	$('.floating-option').click ->
		$(this).hide();
		$('.cc').show();
		$('input.shorter').removeClass('.shorter')
