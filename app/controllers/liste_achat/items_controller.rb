class ListeAchat::ItemsController < ApplicationController
  before_action :authenticate_user!
  def create
    liste_achat = current_user.liste_achat || current_user.create_liste_achat
    fourniture = current_user.fournitures.find(params[:fourniture_id])

    item = liste_achat.liste_achat_items.find_or_initialize_by(fourniture: fourniture)
    item.quantity ||= 1
    item.save

    redirect_back fallback_location: fournitures_path,
                  notice: "Fourniture ajoutée à la liste d'achat."
  end

  def destroy
    liste_achat = current_user.liste_achat || current_user.create_liste_achat
    item = liste_achat.liste_achat_items.find(params[:id])
    item.destroy

    redirect_to liste_achat_path, notice: "Fourniture retirée de la liste d'achat."
  end
end
