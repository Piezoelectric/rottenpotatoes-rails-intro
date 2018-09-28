class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  before_filter :init_session

  def init_session
    session[:ratings] ||= {"G"=>"1", "PG-13"=>"1", "PG"=>"1", "R"=>"1", "NC-17"=>"1"}
    @movies ||= Movie.all
    printf("Session debug: " + session[:ratings].to_s)
  end
  
  def reset_session
    reset_session
  end
  
  protect_from_forgery with: :exception
end
