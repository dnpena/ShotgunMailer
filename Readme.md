#ShotgunMailer

ShotgunMailer shoots your organization's email hassle in the face!  

If you work on an organization that uses shared addresses like contact@yourdomain.com or sales@yourdomain.com, this is for you. If you just want a serious and private email address, this is also for you. And did I mention it is FREE?

With ShotgunMailer you have more control over your organization's emails and you can avoid double answers and inconsistency.
(And it doesn't have to cost you 5USD per account. It's your server, your privacy, your money.)

Power your organization emails using ShotgunMailer!
<!-- SAMPLE IMAGE -->

##Getting started

The first step is actually buy a domain like on [Godaddy](http://www.godaddy.com/). From now on it's going to be `yourdomain.com`  

Clone this repo, push it to [Heroku](http://heroku.com)(from now on http://example.herokuapp.com) and install the [MailGun](https://addons.heroku.com/mailgun) add-on. Other add-ons like [pg-backups](https://addons.heroku.com/pgbackups) and [NewRelic](https://addons.heroku.com/newrelic) are highly recommended.  

To handle the DNS, I recommend using [Cloudflare](http://cloudflare.com) and following this heroku [documentation](http://www.higherorderheroku.com/articles/cloudflare-dns-heroku/).  

Now, by clicking on the MailGun add on you will be on logged on to your account. Here you should follow the oficial [documentation](http://documentation.mailgun.com/quickstart.html#verifying-your-domain) and **verify your domain**. This could take a while on their end. Make sure you setup the "Spam Filter Settings" to deliver the emails but with flags.   

You should rename the *config/public_application.yml* to *config/application.yml*(and optionally add a S3 account for Avatars). Once you have your user/pass, copy them in the *config/application.yml* file. Remember to upload the ENV variables with `rake figaro:heroku` and restart your server to test locally.  
  
Now for the last part, you need to setup your MailGun Routes in the routes tab accessed through Heroku. You should make all routes send the emails as post to *http://example.herokuapp.com/emails* so that they appear on your inbox.

Thats it. Now you can send and receive emails as **@yourdomain.com

##Pending Tasks / Ideas

* Separate emails when adding commas. Use some tag-input css & js
* Close & capture css inside emails & change links to open in new tab (iframe?)
* Soft delete conversations
* Ability to mark emails and senders as spam
* Deliver spam, but add X-Mailgun-SFlag and X-Mailgun-SScore headers
* See the senders "real name" and not just the ugly email
* When the inbox is empty, show "INBOX ZERO"
* Check events authenticity with Mailgun's signature
* New design like Airmail or something
* Add tests
* Add the ability to create 'groups' so that some can send and receive as that address(work@example.com)
* Only show emails in inbox that are for the user or that are global
* Create a Demo with link to heroku
* Add pagination to emails (scroll down and pull to refresh?)
* Add signature to users
* Add email actions as batch. It should work first selecting emails and then selecting the action.
* Add a little AJAX and/or Angular.js
* Add a different admin interface, with basic usage graphs
* Implement a robust and hopefully somewhat Restful API and POP3 things
* Use central domain shotgunmailer.com
* Make mobile apps and dream on
* ...

##Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.

If you add functionality to this application, create an alternative implementation, or build an application that is similar, please contact me and I'll add a note to the README so that others can find your work.

##Credits

Developed by [Max Findel](https://github.com/maxfindel) & the team at [Brainshots](http://brainshots.cl)




