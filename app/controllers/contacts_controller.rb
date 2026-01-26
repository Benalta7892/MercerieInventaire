class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  def new
  end

  def create
    last = session[:last_contact_sent_at]

    if last.present? && Time.current.to_i - last.to_i < 30
      redirect_to contact_path, alert: "Merci d'attendre 30 secondes avant de renvoyer."
      return
    end

    return head :ok if params[:website].present?

    name = params[:name]
    email = params[:email]
    message = params[:message]

    if name.blank? || email.blank? || message.blank?
      flash.now[:alert] = "Tous les champs sont obligatoires."
      return render :new, status: :unprocessable_entity
    end

    ContactMailer.contact_email(name:, email:, message:).deliver_later
    redirect_to contact_path, notice: "Votre message a été envoyé avec succès."
  end
end
