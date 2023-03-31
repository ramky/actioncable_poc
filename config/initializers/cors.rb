# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*'
#     # origins 'http://dev.ram-iyer.com'
#     resource '*', headers: :any, methods: [:get, :post, :patch, :put]
#   end
# end