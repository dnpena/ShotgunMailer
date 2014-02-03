#ShotgunMailer

ShotgunMailer allows you to handle multiple custom email accounts without losing any information. If you handle an organization where everyone sends emails to everyone, you want to have some control and avoid double answers and inconsistency. (And avoid paying 5USD per account)

<!-- SAMPLE IMAGE -->

##Getting started

The first step is actually buy a domain. From now on its `example.com`  

Clone this repo, push it to [Heroku](http://heroku.com)(from now on http://example.herokuapp.com) and install the [MailGun](https://addons.heroku.com/mailgun) add-on. Other add-ons like [pg-backups](https://addons.heroku.com/pgbackups) and [NewRelic](https://addons.heroku.com/newrelic) are recommended.  

To handle the DNS, I recommend using [Cloudflare](http://cloudflare.com) and following this heroku [documentation](http://www.higherorderheroku.com/articles/cloudflare-dns-heroku/).  

Now, by clicking on the MailGun add on you will be on your account. Here you should follow the oficial [documentation](http://documentation.mailgun.com/quickstart.html#verifying-your-domain) and **verify your domain**. This could take a while.  

You should rename the *config/public_application.yml* to *config/application.yml*(and add a S3 account for Avatars). Once you have your user/pass, copy them in the *config/application.yml* file. Remember to upload the ENV variables with `rake figaro:heroku` and restarte your server to test locally.  
  
Now for the last part, you need to setup your MailGun Routes in the routes tab. You should make all routes send the emails as post to *http://example.herokuapp.com/emails* so that they appear on your inbox.

Thats it. Now you can send and receive emails 

##Pending Tasks / Ideas

* When the inbox is empty, show "INBOX ZERO"
* Create a Demo with link to heroku
* Only show emails in inbox that are for the user or taht are global
* Add the ability to create 'groups' so that some can send and receive as that address(work@example.com)
* Add pagination to emails
* Add signature to users
* Better Readme and documentation
* Add email actions as batch. It should work first selecting emails and then selecting the action.
* Add a little AJAX or Angular.js
* Add a different admin interface, with basic usage graphs
* Implement a robust and hopefully Rest API
* ...

##Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.

If you add functionality to this application, create an alternative implementation, or build an application that is similar, please contact me and I'll add a note to the README so that others can find your work.

##Credits

Developed by Max Findel & the team at [Brainshots](http://brainshots.cl)




