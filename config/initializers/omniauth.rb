keycloak = Rails.application.credentials.keycloak

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
