Blog
================

[ ![Codeship Status for christophe-dufour/blog](https://codeship.com/projects/c2deea30-c44f-0132-ce5c-46867e328226/status?branch=master)](https://codeship.com/projects/74096)
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application is just my blog. You can check it at [christophe-dufour.fr](https://www.christophe-dufour.fr) (migration in progress for now)

Why did I create my own blog?
-----------

There are tons of blog engine in the Internet.

I just want to have fun creating my own app and testing some techno on a "side project".

I also made it to be as slim and as fast as possible.

The technologies I use for this blog
-------------

- Ruby 2.2.1
- Rails 4.2.0 (I expect to test Active Job)
- HTMLcompressor (To make output as slim as possible)
- Omniauth (I am the only author for my blog, so I expect to use my google account to log in to the admin section and not have to deal with a User table)
- SLIM (I already try ERB and HAML, so it's time to try slim)
- Mongoid (I'm always working with active record and postgres, I want to have to experience on NoSQL)
- AngularJS (My admin section is full is Angular)
- Active Model Serializers (I prefer it over JBuilder)
- Rails Asset ([You can check out my blog post about rails asset](http://www.christophe-dufour.fr/rails/assets/2015/04/15/how-to-provide-assets-on-a-rails-project.html))


