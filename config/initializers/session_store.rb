# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_VersionOne_session',
  :secret      => '5e67010dafe368cfa83f587b3522a866b6b3d03394a119c1d3144923f32dceb48d29f79d57999a5aca87805cfcc7eacfde4b926df820b74f9b389a8f857d7fc9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
