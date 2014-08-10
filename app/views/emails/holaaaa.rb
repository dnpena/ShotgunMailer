
c = Conversation.create({subject: 'Primer Conversation to ShotgunMailer'})
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Primer Mail This is a test content for the message.'
e.body_html = 'Primer Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Primero This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Segundo Mail is a test content for the message.'
e.body_html = 'Segundo Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Segundo Mail This is a <b>test content</b> for the message'
e.save

c = Conversation.create({subject: 'Segunda Conversation to ShotgunMailer'})
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Primer Mail This is a test content for the message.'
e.body_html = 'Primer Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Primero This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Segundo Mail is a test content for the message.'
e.body_html = 'Segundo Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Segundo Mail This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Tercer Mail is a test content for the message.'
e.body_html = 'Tercer Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Tercer Mail This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Cuarto Mail is a test content for the message.'
e.body_html = 'Cuarto Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Cuarto Mail This is a <b>test content</b> for the message'
e.save

c = Conversation.create({subject: 'Tercer Conversation to ShotgunMailer'})
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Primer Mail This is a test content for the message.'
e.body_html = 'Primer Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Primero This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Segundo Mail is a test content for the message.'
e.body_html = 'Segundo Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Segundo Mail This is a <b>test content</b> for the message'
e.save

c = Conversation.create({subject: 'Cuarto Conversation to ShotgunMailer'})
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Primer Mail This is a test content for the message.'
e.body_html = 'Primer Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Primero This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Segundo Mail is a test content for the message.'
e.body_html = 'Segundo Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Segundo Mail This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Tercer Mail is a test content for the message.'
e.body_html = 'Tercer Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Tercer Mail This is a <b>test content</b> for the message'
e.save
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'Cuarto Mail is a test content for the message.'
e.body_html = 'Cuarto Mail This is a <b>test content</b> for the message. <br> '
e.stripped_html = 'Cuarto Mail This is a <b>test content</b> for the message'
e.save
