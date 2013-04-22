class BookwormMailer < ActionMailer::Base
  default to: ENV["GMAIL_USERNAME"]

  def form_email(from, subject, body)
    @body = body
    mail(:from => from, :subject => subject)
  end

end
