class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(owner)
    restaurants_path
  end
  
  def after_sign_out_path_for(owner)
    restaurants_path
  end
  
  def  after_sign_in_path_for(user)
    restaurants_path
  end
  
  def after_sign_out_path_for(user)
    restaurants_path
  end
end
