First get some dependencies. This is assuming you have Ruby 1.9.3 or greater installed already. Install bundler located at:
http://gembundler.com/
Then install rvm (Ruby Version Manager) located at:
https://rvm.io/rvm/install/
Then install ruby on rails located at:
http://rubyonrails.org/

After all the installations have completed successfully, navigate to the root directory of the project and type in a console shell "bundle install" and after this completes run "rake db:setup" and after this completes run "rake db:migrate". Finally after all the setup has been ran run "rails s" to start the rails server on localhost:3000 and navigate to this using a web browser to see the project.

Thanks,
-Team Prometheus
