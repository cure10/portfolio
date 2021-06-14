class ContactMailer < ApplicationMailer

  def send_mail(contact)
    @contact = contact
    mail to: [contact.email, ENV['TOMAIL']]
  end

end
