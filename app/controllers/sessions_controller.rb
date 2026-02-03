class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]

    if auth.nil? || auth.info.nil?
      redirect_to root_path, alert: "Authentication failed. Please try again."
      return
    end

    # Store user information in the session
    session[:user_info] = {
      uid:      auth.uid,
      provider: auth.provider,
      name:     auth.info.name,
      email:    auth.info.email,
      groups:   auth.extra.raw_info.groups
    }

    redirect_to root_path, notice: "Signed in as #{session[:user_info][:name]}"
  end

  def destroy
    reset_session

    logout_url = "#{keycloak_base_url}/realms/#{keycloak_realm}/protocol/openid-connect/logout" \
                 "?redirect_uri=#{CGI.escape(root_url)}"

    redirect_to logout_url, allow_other_host: true, notice: "Signed out!"
  end

  private

  def keycloak_base_url
    host = Rails.application.credentials.dig(:keycloak, :host) || ENV["KEYCLOAK_HOST"] || "http://localhost"
    "#{host}/auth" # Remove /auth when moving to keycloak 18+
  end

  def keycloak_realm
    Rails.application.credentials.dig(:keycloak, :realm) || ENV["KEYCLOAK_REALM"] || "master"
  end
end
