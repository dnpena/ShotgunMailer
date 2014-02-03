class EmailsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => [:create]

  before_action :set_email, only: [:show, :edit, :update, :destroy, :toggle_value]

  load_and_authorize_resource
  
  # GET /emails
  def index
    unless params[:sent]
      @emails = Email.where(:archived => params[:archived] ? true : false, :user_id => nil).order('created_at desc')
    else
      @emails = Email.where('user_id IS NOT NULL').order('created_at desc')
    end
    @archived = params[:archived]
    @sent = params[:sent]
  end

  # GET /emails/1
  def show
    @original_email = @email
    @email.update_attribute(:read, true)
    @answers = []#Email.where(:convesation_id => @email.id)
  end

  def toggle_value
    if ['archived', 'read', 'answered'].include?(params[:attr])
      val = params[:val]!='true'
      @email.update_attribute(params[:attr], val)
      if ['answered'].include?(params[:attr])
        redirect_to email_path(params[:id]), notice: "Email was marked as #{(val ? '' : 'un')+params[:attr]}."
      else
        redirect_to emails_path, notice: "Email was marked as #{(val ? '' : 'un')+params[:attr]}."
      end
    end
  end

  # GET /emails/new
  def new
    @email = Email.new
    @email.subject = ''
    @recipients = Email.select(:recipient).where(:user_id => current_user.id).group(:recipient).collect(&:recipient).to_s
    @url = send_email_path
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  def send_email
    @email = Email.new(email_params)

    if @email.save
      @email.update_attribute(:user_id, current_user.id)
      @email.update_attribute(:read, true)
      UserMailer.shotgun_email(@email).deliver
      return redirect_to emails_path, notice: 'Email was successfully sent.'
    else
      return redirect_to emails_path, notice: 'An error has occurred.'
    end
  end
  #Method used by MailGun to post messages
  def create
    @email_params = email_params
    @email_params[:body_plain] = @email_params['body-plain']
    @email_params[:stripped_html] = @email_params['stripped-html']
    @email_params[:body_html] = @email_params['body-html']
    ['body-plain', 'body-html', 'stripped-html'].collect{|p| @email_params.delete(p) }
    @email = Email.new(@email_params)

    if @email.save
      return render nothing: true, code: 200
    else
      return render nothing: true, code: 500
    end
  end

  # PATCH/PUT /emails/1
  def update
    @reply = Email.new(email_params)
    # @reply.conversation_id = @email.id
    @reply.user_id = current_user.id
    @reply.save

    @email.update_attribute(:answered, true)

    UserMailer.shotgun_email(@reply).deliver

    return redirect_to @email, notice: 'Email was successfully sent.'
  end

  # DELETE /emails/1
  def destroy
    @email.destroy
    redirect_to emails_url, notice: 'Email was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      begin
        params.require(:email).permit(:sender, :recipient, :subject, :body_html)
      rescue
        params.permit(:sender, :recipient, :subject, 'body-plain', 'stripped-html', 'body-html')
      end
    end
end
