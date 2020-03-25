VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "#{Rails.root}/spec/cassettes"
  c.filter_sensitive_data('<TwitterConsumerKey>') { Settings.twitter.consumer_key }
  c.filter_sensitive_data('<TwitterAccessToken>') { Settings.twitter.access_token }
end