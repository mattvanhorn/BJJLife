Rails.configuration.action_mailer.default_url_options = { :host => case Rails.env
  when 'production'
    'livingbjj.com'

  when 'development'
    'localhost:3000'

  else
    if ENV['TDDIUM']
      "localhost:#{53891+ENV.fetch('TDDIUM_TID', 0).to_i}"
    else
      'example.com'
    end
  end
}
