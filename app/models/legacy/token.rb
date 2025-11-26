class Legacy::Token
  require "utils/python_xor"
  def generate_token(uuid)
    t=Time.now.strftime("%s")
    str = t + "\n" + uuid
    cipher_text = python_xor(Rails.application.credentials.legacy[:CRYPTOPASS], str)
    cipher_text
  end
  def valid?(uuid, token)
    plain_text = python_xor(Rails.application.credentials.legacy[:CRYPTOPASS], CGI.unescape(token))
    str = plain_text.split("\n")
    t_delta = Time.now.strftime("%s").to_i - str[0].to_i
    if str[1] == uuid and t_delta < 60 and t_delta >= 0
      return true
    end
    false
  end
  def generate_admin_token(uuid)
    str = uuid[0, 7]
    admin_token = python_xor(Rails.application.credentials.legacy[:CRYPTOPASS], str)
    admin_token
  end
end
