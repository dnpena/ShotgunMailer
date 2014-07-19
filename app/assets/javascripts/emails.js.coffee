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

	# CC & BCC activator
	$('.floating-option').click ->
		$(this).hide();
		$('.cc').show();
		$('input.shorter').removeClass('.shorter')


	# HTML Capsule to display html_safe content of emails without changing the layout
	$('.html-capsule').each (e) ->
		doc = $(this)[0].contentWindow.document
		doc.open();
		data = $(this).attr('body_html')
		data = if data.length>1 then data else $(this).attr('body_plain')
		doc.write(data)
		doc.close();