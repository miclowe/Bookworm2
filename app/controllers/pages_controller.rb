class PagesController < ApplicationController

  def index
    
  end

  def contact

  end

  def send_email
    @from = params[:from]
    @subject = params[:subject]
    Contact.form_email(@from, @subject, params[:body]).deliver
  end

end
