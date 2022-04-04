Edify
================

Edify is a tool for leaders in the Church of Jesus Christ of Latter-day Saints. It keeps track of speakers at Sacrament 
meetings and makes it easier to determine which members may be appropriate to invite to speak.

Ruby on Rails
-------------

This application requires:

- Ruby 3.1
- Rails 7.0

Learn more about [Installing Rails](https://gorails.com/setup/osx/10.12-sierra).

Getting Started
---------------
### Setup Local Environment

Instructions follow for setting up a local development environment in MacOS.

**Homebrew**

Install [Homebrew](http://brew.sh/).

**Clone the Repo**

Clone the repository to your local machine by [forking the repo](https://help.github.com/articles/fork-a-repo/)

**Ruby**

Ruby is installed by default on all MacOS systems, but it lives in the root directory and probably won't be the correct
version to run Edify. Nearly all Ruby developers use a Ruby environment manager like rbenv, rvm, or asdf. Instructions
for installing rbenv follow, but feel free to use one of the other tools if you wish.

#### Install rbenv

1. `$ brew update`
2. `$ brew install rbenv`

3. `$ cd` into your local `edify` directory
4. `$ rbenv init` For any questions around setting up rbenv see https://github.com/rbenv/rbenv
5. `$ rbenv local` to see the Ruby version Edify is currently using
6. `$ rbenv install <current ruby version>`
7. `$ rbenv rehash` then restart the terminal session

**Postgres**

Edify uses Postgres, so you'll need to install it if you haven't already.

1. `$ brew install postgres`
2. `$ brew services start postgres`

**Redis**

Edify relies on Sidekiq for background jobs, and Sidekiq needs Redis. Install Redis using homebrew:

1. `$ brew install redis`
2. `$ brew services start redis`

**Javascript Runtime + Yarn**

1. Node can be installed using homebrew, but it takes a long time and may cause dependency conflicts in your local
environment. Instead, install Node.js by downloading the package installer from nodejs.org
2. Install Yarn with homebrew

> `$ brew install yarn`

**Rails and Gems**

Setup the app by running the setup script:

1. `$ ./bin/setup`
2. `$ ./bin/dev` to start the servers in your dev environment
3. Type `localhost:3000` in a browser

*Test Users*

After you setup/seed your database, you should have at least two test users:
```
| Role  | Email                  | Password |
| ----- | ---------------------- | -------- |
| admin | admin@example.com      | password |
| user  | another@example.com    | password |
```

You will also have at least two test units (wards). Each test user belongs to a test unit.

**Continuous Integration**

(Github CI to come)

Support
-------------------------

Still having issues setting up your local environment?
Create an [issue](https://github.com/moveson/edify/issues/new) and we will try to help!

Contributing
-------------

We love Issues but we love Pull Requests more! If you want to change something or add something feel free to do so. If 
you don't have enough time or skills start an issue. Below are some loose guidelines for contributing.

### Pull Requests

Writing code for something is the fastest way to get feedback. It doesn't matter if the code is a work in progress or 
just a spike of an idea we'd love to see it. Testing is critical to our long-term success, so code submissions must 
include tests covering all critical logic. :heart:

### Issues

Be detailed. They only person who knows the bug you are experiencing or feature that you want is you! So please be as 
detailed as possible. Include labels like `bug` or `enhancement` and you know the saying a picture is worth a thousand 
words. So if you can grab a screenshot or gif of the behavior even better!


Credits
-------

Edify got a boost from [Jumpstart](https://github.com/excid3/jumpstart), an open-source project that provides
authentication, notifications, and administrator tools out of the box for new Rails apps.

License
-------

[The MIT License](https://github.com/moveson/edify/blob/master/LICENSE.md)

Copyright
---------

Copyright (c) 2022 by Mark Oveson. See license for details.
