# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_StoryHub_session',
  :secret      => '7f6d614531883aee4318f6a70fd49c1236a665bdee517ab2cfc25b0eab20e06fa3fd0eede03ed898490cfa4ce09216479383d48390cb5a041fe41754831aac87'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
