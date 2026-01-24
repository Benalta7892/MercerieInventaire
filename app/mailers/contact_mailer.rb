class ContactMailer < ApplicationMailer
  def contact_email(name:, email:, message:)
    @name = name
    @email = email
    @message = message

    mail(to: ENV.fetch("CONTACT_EMAIL"), subject: "Mercerie Inventaire - Nouveau message de #{name}")
  end
end
