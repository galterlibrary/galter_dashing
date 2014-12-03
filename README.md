Check out http://shopify.github.com/dashing for more information.

DEPLOYMENT

1. Set up ssh keys for user `deploy` to github.com for the repo
2. Clone code to `/var/www/apps/galter_dashing`
3. Run `bundle install` io the app directory.
4. Copy `local_env.rb` file with secrets to the app directory
5. Create apache config: `/etc/httpd/conf.d/dashing.conf`
```
<VirtualHost *:80>
    PassengerRuby /usr/local/rvm/wrappers/ruby-2.1.5/ruby
    # Always keep one and only one instance in the memory
    # so the event scheduler (rufus) is not killed or duplicated
    PassengerSpawnMethod direct
    PassengerMaxPreloaderIdleTime 0
    PassengerMaxInstancesPerApp 1
    PassengerMinInstances 1
    ServerName vfsmghsldash01.fsm.northwestern.edu
    DocumentRoot /var/www/apps/galter_dashing/public
    <Directory /var/www/apps/galter_dashing/public>
      AllowOverride all
      Options -MultiViews
    </Directory>
</VirtualHost>
```

`sudo service httpd restart`
