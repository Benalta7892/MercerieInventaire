class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  def new
  end

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]

    if name.blank? || email.blank? || message.blank?
      flash.now[:alert] = "Tous les champs sont obligatoires."
      return render :new, status: :unprocessable_entity
    end

    ContactMailer.contact_email(name:, email:, message:).deliver_now
    redirect_to contact_path, notice: "Votre message a été envoyé avec succès."
  end
end
