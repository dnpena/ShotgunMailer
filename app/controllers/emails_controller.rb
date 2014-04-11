class EmailsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, :only => [:create]

  before_action :set_email, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :except => [:toggle_value]
  
  # GET /emails
  def index
    unless params[:sent]
      @emails = Conversation.includes(:emails).where(:archived => params[:archived] ? true : false).order('updated_at desc')
    else
      @emails = Email.where(spam: false).where('user_id IS NOT NULL').order('created_at desc')
    end
    @archived = params[:archived]
    @sent = params[:sent]
  end

  # GET /emails/1
  def show
    @email.save
    @conv = @email.conversation
    @conv.update_attribute(:read, true)
    @emails = Email.where(:conversation_id => @conv.id)
  end

  def toggle_value
    #TODO authenticate tat the conversation is his to update
    @conv = Conversation.find params[:id]
    if ['archived', 'read', 'answered'].include?(params[:attr])
      val = params[:val]!='true'
      @conv.update_attribute(params[:attr], val)
      if ['answered'].include?(params[:attr])
        last_email = @conv.emails.last
        redirect_to email_path(last_email.id), notice: "Email was marked as #{(val ? '' : 'un')+params[:attr]}."
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
      @email.conversation.update_attribute(:read, true)
      @email.conversation.update_attribute(:archived, true)
      @email.conversation.update_attribute(:answered, true)
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
    @email.conversation_id = @email.find_conversation
    # We check if it's in the spam list. If that is the case, no conversation is created
    if Spam.search_pattern(@email.sender)
      @email.spam = true
    end
    if @email.save
      if @email.conversation
        @email.conversation.update_attribute(:read, false)
        @email.conversation.update_attribute(:answered, false)
        @email.conversation.update_attribute(:archived, false)
      end
      return render nothing: true, code: 200
    else
      return render nothing: true, code: 500
    end
  end

  # PATCH/PUT /emails/1
  def update
    @reply = Email.new(email_params)
    @reply.conversation_id = @email.conversation_id
    @reply.user_id = current_user.id
    @reply.save

    @conv = @email.conversation
    @conv.update_attribute(:answered, true)

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
        params.require(:email).permit(:sender, :recipient, :subject, :body_html, :cc, :bcc)
      rescue
        params.permit(:sender, :recipient, :subject, 'body-plain', 'stripped-html', 'body-html')
      end
    end
end
