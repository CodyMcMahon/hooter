def user_signed_in?
    session[:user_id] ? true : false
end