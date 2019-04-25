# SixArm.com → Ruby → <br> Capybara session cookies for Rails testing

* Doc: <http://sixarm.com/sixarm_ruby_capybara_session_cookies/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_capybara_session_cookies>
* Repo: <http://github.com/sixarm/sixarm_ruby_capybara_session_cookies>
<!--header-shut-->


## Introduction

This gem wraps the code and writeup from Steve Richert at Collective Idea:
http://collectiveidea.com/blog/archives/2012/01/05/capybara-cucumber-and-how-the-cookie-crumbles/

All credit for this goes to Steve.

For docs go to <http://sixarm.com/sixarm_ruby_capybara_session_cookies/doc>

Want to help? We're happy to get pull requests.


<!--install-open-->

## Install

### Gem

To install this gem in your shell or terminal:

    gem install sixarm_ruby_capybara_session_cookies

### Gemfile

To add this gem to your Gemfile:

    gem 'sixarm_ruby_capybara_session_cookies'

### Require

To require the gem in your code:

    require 'sixarm_ruby_capybara_session_cookies'

<!--install-shut-->


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
