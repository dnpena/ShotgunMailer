# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin user
admin = User.where(:email => 'admin@'+ENV["DOMAIN_NAME"]).first_or_create
admin.password = 'admin'
admin.password_confirmation = 'admin'
admin.first_name = 'My'
admin.last_name = 'Name'
admin.save
admin.update_attribute :active, true
admin.update_attribute :admin, true

#Test Emails
c = Conversation.create({subject: 'Welcome to ShotgunMailer'})
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: c.subject, conversation_id: c.id})
e.body_plain = 'This is a test content for the message.'
e.body_html = 'This is a <b>test content</b> for the message. <br> '
#commented reply TODO gmail quote div
# e.body_html += "<br><br>#{e.created_at.strftime('%Y-%m-%d %H:%M:%S %p')} contact@example.com:"
# e.body_html += '<blockquote type="cite" class="clean_bq gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex" >'
# e.body_html += "This is a commented reply from the previous email."
# e.body_html += "</blockquote>"
#This contains no quotations
e.stripped_html = 'This is a <b>test content</b> for the message'
e.save



