require 'digest/md5'

$PREDEFINED_USERNAME = 'admin'
$PREDEFINED_PASSWORD = 'password'

def encrypt_password(password)
  return Digest::MD5.hexdigest(password)
end

def web_auth(username, password)

  loginUser = User.find_by_login(username)

  if loginUser.nil?

    # User not found.
    # Check whether the user is built-in user.
    result = (username == $PREDEFINED_USERNAME && password == $PREDEFINED_PASSWORD)
    return result

  else
    # User found.
    # Check the password.
    if password.nil?
      # Null password is not allowed.
      return false
    else
      passwdDigest = encrypt_password(password)
      return passwdDigest == loginUser.crypted_password
    end
  end
end

def web_auth_role(username, password, role)

  loginUser = User.find_by_login(username)

  if loginUser.nil?

    # User not found.
    # Check whether the user is built-in user.
    result = (username == $PREDEFINED_USERNAME && password == $PREDEFINED_PASSWORD)
    return result

  else
    # User found.
    # Check the password.
    if password.nil?
      # Null password is not allowed.
      return false
    else
      passwdDigest = encrypt_password(password)
      return false if passwdDigest != loginUser.crypted_password
      return false if loginUser.roles.nil?
      loginUser.roles.split(',').each do |r|
        return true if role == r
      end
      return false
    end
  end
end

module ModuleDbAuthenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      next web_auth(username, password)
    end
  end

end

module ModuleDbAuthenticateAdmin

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      next web_auth_role(username, password, 'admin')
    end
  end

end
