keycloak = Rails.application.credentials.keycloak
if keycloak.nil?
  keycloak = {}
  keycloak[:client_id] = ENV["KEYCLOAK_CLIENT_ID"] || "smolt2"
  keycloak[:client_secret] = ENV["KEYCLOAK_CLIENT_SECRET"] || "CHANGE_ME"
  keycloak[:host] = ENV["KEYCLOAK_HOST"] || "https://sso.mythtv.org"
  keycloak[:realm] = ENV["KEYCLOAK_REALM"] || "MythTV"
  keycloak[:redirect_uri] = ENV["KEYCLOAK_REDIRECT_URI"] || "https://smolt.mythtv.org/auth/openid_connect/callback"
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect, {
    name: :openid_connect,
    issuer: "#{keycloak[:host]}/auth/realms/#{keycloak[:realm]}",
    discovery: true,
    scope: [ :openid, :email, :profile, :groups ],
    response_type: :code,
    uid_field: "preferred_username",
    client_options: {
      scheme: "https",
      host: "sso.mythtv.org",
      identifier: keycloak[:client_id],
      secret: keycloak[:client_secret],
      redirect_uri: keycloak[:redirect_uri]
    }
  }
end
