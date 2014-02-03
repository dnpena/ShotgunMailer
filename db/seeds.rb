# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin user
admin = User.where(:email => 'admin@example.com').first_or_create
admin.password = 'admin'
admin.password_confirmation = 'admin'
admin.first_name = 'My'
admin.last_name = 'Name'
admin.save
admin.update_attribute :active, true
admin.update_attribute :admin, true

#Test Emails
#TODO Sample conversation
e = Email.create({sender: 'welcome@example.com', recipient: 'contact@example.com', subject: 'Welcome to ShotgunMailer'})
e.body_plain = 'This is a test content for the message.'
e.body_html = 'This is a <b>test content</b> for the message. <br> '
#commented reply
e.body_html += "<br><br><blockquote type=\"cite\" class=\"clean_bq\">"
e.body_html += "This is a commented reply from the previous email."
e.body_html += "</blockquote>"
#This contains no quotations
e.stripped_html = 'This is a <b>test content</b> for the message'
e.save