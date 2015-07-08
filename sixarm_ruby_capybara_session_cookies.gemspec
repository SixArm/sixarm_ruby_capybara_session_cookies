# -*- coding: utf-8 -*-

Gem::Specification.new do |s|

  s.name              = "sixarm_ruby_capybara_session_cookies"
  s.summary           = "SixArm.com » Ruby » Capybara session cookies"
  s.description       = "Capybara session cookies for Rails testing"
  s.version           = "1.0.2"

  s.author            = "SixArm"
  s.email             = "sixarm@sixarm.com"
  s.homepage          = "http://sixarm.com/"
  s.licenses          = ["BSD", "GPL", "MIT", "PAL", "Various"]

  s.signing_key       = "/opt/keys/sixarm/sixarm-rsa-4096-x509-20150314-private.pem"
  s.cert_chain        = ["/opt/keys/sixarm/sixarm-rsa-4096-x509-20150314-public.pem"]

  s.platform          = Gem::Platform::RUBY
  s.require_path      = "lib"
  s.has_rdoc          = true

  s.files = [
    ".gemtest",
    "CHANGES.md",
    "LICENSE.md",
    "Rakefile",
    "README.md",
    "VERSION",
    "lib/sixarm_ruby_capybara_session_cookies.rb",
  ]

  s.test_files = [
    "test/sixarm_ruby_capybara_session_cookies_test.rb",
  ]

  s.add_dependency('rails', '>= 3', '< 999')
  s.add_dependency('action_dispatch', '>= 3', '< 999')
  s.add_dependency('capybara', '>= 1', '< 999')

end
