require 'simplecov'

if ENV['CI'].present?
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter 'app/secrets'
  end
else
  SimpleCov.start
end
