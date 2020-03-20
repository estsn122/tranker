RSpec.configure do |config|
  config.before(:each, type: :system) do
    # TODO ウィンドウが立ち上がらないので対処
    # driven_by(:rack_test)
    driven_by(:selenium_chrome)
  end
  config.before(:each, type: :system, js: true) do
    driven_by(:selenium_chrome_headless)
  end
end
