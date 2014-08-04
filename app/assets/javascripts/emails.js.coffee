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
		path = $(this).attr('href')
		$.ajax path,
		type: 'GET'
		dataType: 'html'
		data: {mail_id: $('this').attr('id')}
		error: (jqXHR, textStatus, errorThrown) ->
			$('body').append "AJAX Error: #{textStatus}"
		success: (data, textStatus, jqXHR) ->
			mail = $.parseJSON(data)
			for key, value of mail

					$('.navigation').html(value[0].subject)
					panel_primerio = $("<div/>").addClass "panel panel-primary"
					$('.actual-email').html(panel_primerio).css('visibility', 'visible');

					for a, b of value
						console.log b
						panHeading = $("<div/>").addClass "panel-heading"
						panelFrom = $("<div/>").addClass "from"
						panelFrom.html(b.sender)
						panHeading.append(panelFrom)
						
						panelBody = $("<div/>").addClass "panel-body"
						paneltext = $("<div/>").addClass "mail-text"
						paneltext.html(b.content).append(b.contenthtml)	
						panelBody.append(paneltext)
						$('.panel.panel-primary').append(panHeading).append(panelBody)

	$('.checky').click ->
		$(this).hide();

	
		