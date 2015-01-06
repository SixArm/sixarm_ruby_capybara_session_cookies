# SixArm.com » Ruby » <br> Capybara session cookies for Rails testing

* Doc: <http://sixarm.com/sixarm_ruby_capybara_session_cookies/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_capybara_session_cookies>
* Repo: <http://github.com/sixarm/sixarm_ruby_capybara_session_cookies>
* Email: Joel Parker Henderson, <joel@sixarm.com>


## Introduction

This gem wraps the code and writeup from Steve Richert at Collective Idea:
http://collectiveidea.com/blog/archives/2012/01/05/capybara-cucumber-and-how-the-cookie-crumbles/

All credit for this goes to Steve.

For docs go to <http://sixarm.com/sixarm_ruby_capybara_session_cookies/doc>

Want to help? We're happy to get pull requests.


## Install quickstart

Install:

    gem install sixarm_ruby_capybara_session_cookies

Bundler:

    gem "sixarm_ruby_capybara_session_cookies", "~>1.0.0"

Require:

    require "sixarm_ruby_capybara_session_cookies"


## Install with security (optional)

To enable high security for all our gems:

    wget http://sixarm.com/sixarm.pem
    gem cert --add sixarm.pem
    gem sources --add http://sixarm.com

To install with high security:

    gem install sixarm_ruby_capybara_session_cookies --trust-policy HighSecurity


## Details


From Steve's writeup...

When I write a new Rails application, it often needs some sort of user authentication. 

I like to test authentication in Cucumber.

I want to set the set the signed-in user directly. 

Here’s the current_user helper method in my ApplicationController:

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = cookies[:token] && User.find_by_token(cookies[:token])
    end

Each Capybara driver handles its cookies differently. The cookies hash we access in our step is specific to Rack::Test and is actually a Rack::Test::CookieJar object.

If you want your application cookies to Just Work™ from anywhere in your Cucumber suite, throw the following into features/support/cookies.rb:

    module Capybara
      class Session
        def cookies
          @cookies ||= begin
            secret = Rails.application.config.secret_token
            cookies = ActionDispatch::Cookies::CookieJar.new(secret)
            cookies.stub(:close!)
            cookies
          end
        end
      end
    end

    Before do
      request = ActionDispatch::Request.any_instance
      request.stub(:cookie_jar).and_return{ page.cookies }
      request.stub(:cookies).and_return{ page.cookies }
    end

You’ll need a stubbing library. I’m using RSpec.

This allows each of your Capybara sessions to keep its own separate set of cookies. And they’re real cookies, meaning that you can use cookies.permananent and cookies.signed just like you do in your controllers. Then, after each scenario, Capybara will clean its sessions, along with your cookies.

Just use page.cookies and you’re good to go!

    When /^I am signed in as "([^"]*)"$/ do |email|
      page.cookies[:token] = User.find_by_email!(email).token
    end


## Changes

* 2012-03-14 1.0.0 Update docs, tests
* 2012-01-11 1.0.0 Publish
## License

You may choose any of these open source licenses:

  * Apache License
  * BSD License
  * CreativeCommons License, Non-commercial Share Alike
  * GNU General Public License Version 2 (GPL 2)
  * GNU Lesser General Public License (LGPL)
  * MIT License
  * Perl Artistic License
  * Ruby License

The software is provided "as is", without warranty of any kind, 
express or implied, including but not limited to the warranties of 
merchantability, fitness for a particular purpose and noninfringement. 

In no event shall the authors or copyright holders be liable for any 
claim, damages or other liability, whether in an action of contract, 
tort or otherwise, arising from, out of or in connection with the 
software or the use or other dealings in the software.

This license is for the included software that is created by SixArm;
some of the included software may have its own licenses, copyrights, 
authors, etc. and these do take precedence over the SixArm license.

Copyright (c) 2005-2013 Joel Parker Henderson
