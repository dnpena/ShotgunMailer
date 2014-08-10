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
		elem = $(this)
		doc = elem[0].contentWindow.document
		doc.open();
		data = elem.attr('body_html')
		data = if data.length>1 then data else $(this).attr('body_plain')
		# Now we change all the links to target _blank
		$html = $("<div/>").append(data)
		$html.find('a').attr('target','_blank')
		doc.write($html.html())
		doc.close();

	$('.mails-btn').click (e) ->
		e.preventDefault()
		$(this).removeClass "alert-warning"
		path = $(this).attr('href')
		console.log path
		$.ajax path,
		type: 'GET'
		dataType: 'html'
		data: {mail_id: $('this').attr('id')}
		error: (jqXHR, textStatus, errorThrown) ->
			$('body').append "AJAX Error: #{textStatus}"
		success: (data, textStatus, jqXHR) ->
			$('.mail_panel').html(data)


	$('.checky').click ->
		selects = $('.checky:checked').length 
		if selects>0
			$('.nav.navbar-nav.pull-left').css('visibility', 'visible');
		else	
			$('.nav.navbar-nav.pull-left').css('visibility', 'hidden');

	$('.deletebtn').click ->

		all_ids = []
		i=0
		$('.checky:checked').each ->
			id = $(this).attr("id")
			all_ids[i] = id
			i++
			return
		path = '/emails/delete_many'
		$.ajax path,
		type: 'DELETE'
		dataType: 'html'
		data: {mails_to_delete: all_ids}
		error: (jqXHR, textStatus, errorThrown) ->
			$('body').append "AJAX Error: #{textStatus}"
		success: (data, textStatus, jqXHR) ->
			$('.emails_list').html(data)

	$('.archivebtn').click ->

		all_ids = []
		i=0
		$('.checky:checked').each ->
			id = $(this).attr("id")
			all_ids[i] = id
			i++
			return
		path = '/emails/archive_many'
		$.ajax path,
		type: 'POST'
		dataType: 'html'
		data: {mails_to_archive: all_ids}
		error: (jqXHR, textStatus, errorThrown) ->
			$('body').append "AJAX Error: #{textStatus}"
		success: (data, textStatus, jqXHR) ->
			$('.emails_list').html(data)


	$('.archivebtn').click ->
		selects = $('.checky:checked').length 

	
		