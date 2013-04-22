class BookwormMailer < ActionMailer::Base
  default :to => 'mklowe2012@gmail.com'

  def form_email(from, subject, body)
    @body = body
    mail(:from => from, :subject => subject)
  end

end
