class Legacy::TokenController < ApplicationController
  def token_json
    csrf_token = form_authenticity_token
    # Generate token
    generator = Legacy::Token.new
    cipher_text = generator.generate_token(params[:uuid])
    session[:uuid] = params[:uuid]
    render json: {"tg_flash": "null", "token": CGI.escape(cipher_text), "prefered_protocol": "0.97"}
  end
  def admin_token_json
    legacy_token = Legacy::Token.new
    admin_token = legacy_token.generate_admin_token(params[:uuid])
    render json: {"tg_flash": "null", "token": CGI.escape(admin_token), "prefered_protocol": "0.97"}
  end
end
