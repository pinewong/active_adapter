Bundler.require(:default, :development)

Dir['./spec/support/**/*.rb'].each { |f| require f }
