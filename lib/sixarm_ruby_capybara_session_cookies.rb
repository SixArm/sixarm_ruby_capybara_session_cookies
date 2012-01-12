# -*- coding: utf-8 -*-
=begin rdoc
Please see README.rdoc
=end

require 'capybara'
require 'rails'
require 'action_dispatch'

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
