require 'digest/md5'

def encrypt_password(password)
  return Digest::MD5.hexdigest(password)
end

def web_auth(username, password)

  puts "Username is: #{username}."
  puts "Password is: #{password}."

  loginUser = User.find_by_login(username)

  if loginUser.nil?

    # User not found.
    # Check whether the user is built-in user.
    result = (username == 'admin' && password == 'password')
    return result

  else
    # User found.
    # Check the password.
    if password.nil?
      # Null password is not allowed.
      return false
    else
      passwdDigest = encrypt_password(password)
      puts "passwdDigest is: #{passwdDigest}."
      return passwdDigest == loginUser.crypted_password
    end
  end
end
