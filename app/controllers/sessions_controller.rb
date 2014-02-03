class SessionsController < ApplicationController
  def new
    if current_user
      return redirect_to home_path, :notice => "Already logged in!"
    end
    @user = User.new
  end
    
  def create
  	user = User.authenticate(params[:email], params[:password])
    if user&&user.active==true&&!user.deleted
      
      session[:user_id] = user.id

      if session[:last_uri]
        uri = session[:last_uri]
        session[:last_uri] = nil
        return redirect_to uri, :notice => "You are now logged in!"
      end
      return redirect_to request.referer, :notice => "You are now logged in!"
    else
      if user && user.active!=true
        str = "Check your email and activate your account"
      elsif user && user.deleted!=false
        str = "This account doesn't exist"
      else
        str = "Invalid email or password"
      end
      return redirect_to log_in_path, notice: str
    end
  end
  
  def destroy
    session[:user_id] = nil
    return redirect_to home_path
  end

  def unsubscribe
    @token = Token.find_by_value(params[:token])
    unless @token
      return redirect_to home_path
    end
    @user = @token.user
    Blacklist.create(:email_to => @user.email, :email_from => params[:from], :global => (params[:from] ? false : true))
    @token.destroy
    redirect_to home_path, notice: t('notice.user.unsubscribe')
  end

  #recover pass
  def recover_pass
  end
  def send_pass_recovery
    user = User.find_by_email params[:email]
    if user
      key = user.tokens.first_or_create
      UserMailer.recover_pass(user, key.value).deliver
      return redirect_to home_path, :notice => t('notice.sessions.recovery')
    else
      return redirect_to recover_pass_path, :notice => t('notice.sessions.user_not_found')
    end
  end
  def change_password
    @token = Token.find_by_value(params[:token])
    unless @token
      return redirect_to home_path, :notice => t('notice.sessions.invalid_link')
    end
    @user = @token.user
    @user.update_attribute(:active, true)
    session[:user_id] = @user.id
  end
  def do_change_password
    @token = Token.find_by_value(params[:token])
    unless @token
      return redirect_to home_path, :notice => t('notice.sessions.invalid_link')
    end
    unless params[:password]!=nil&&params[:password].length>3
      return redirect_to :back, :notice => 'Too short'
    end
    @user = @token.user
    @user.update_attribute :password, params[:password]
    Token.delete @token
    return redirect_to home_path, :notice => t('notice.sessions.pass_changed')
  end
  #end recover pass

end



