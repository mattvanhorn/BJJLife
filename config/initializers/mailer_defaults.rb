Rails.configuration.action_mailer.default_url_options = { :host => case Rails.env
  when 'production'
    'livingbjj.com'

  when 'development'
    'localhost:3000'

  else
    'example.com'
  end
}


