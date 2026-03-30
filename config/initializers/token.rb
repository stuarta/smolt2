require "securerandom"

Rails.application.credentials.token_base = SecureRandom.hex(32)
