class HomeController < ApplicationController
  
  def index
  	return redirect_to home_path if current_user
  end


  def home
    
  end

end
