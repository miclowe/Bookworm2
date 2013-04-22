class PagesController < ApplicationController

  def index
    
  end

  def contact

  end

  def send_email
    @from = params[:email]
    @subject = params[:subject]
    BookwormMailer.form_email(params[:email], params[:subject], params[:body]).deliver
  end

end
