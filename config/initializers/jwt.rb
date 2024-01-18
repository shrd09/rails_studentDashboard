# config/initializers/jwt.rb

require 'jwt'

# Set the secret key to something secure and secret
JWT_SECRET_KEY='my_secret_key'

# Set the expiration time for tokens (e.g., 1 hour)
# JWT_EXPIRATION = 40.hour.to_i
