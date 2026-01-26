class ListeAchat::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[edit update destroy]
  def create
    liste_achat = current_user.liste_achat || current_user.create_liste_achat
    fourniture = current_user.fournitures.find(params[:fourniture_id])

    item = liste_achat.liste_achat_items.find_or_initialize_by(fourniture: fourniture)
    item.quantity ||= 1
    item.save

    redirect_back fallback_location: fournitures_path,
                  notice: "Fourniture ajoutée à la liste d'achat."
  end

  def edit; end

  def update
    qty = item_params[:quantity]

    ActiveRecord::Base.transaction do
      @item.update!(quantity: qty)
      @item.fourniture.update!(quantity: qty) # ✅ met à jour le stock global
    end

    redirect_to(params[:return_to].presence || liste_achat_path, notice: "Stock mis à jour.")
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  def destroy
    liste_achat = current_user.liste_achat || current_user.create_liste_achat
    item = liste_achat.liste_achat_items.find(params[:id])
    item.destroy

    redirect_to liste_achat_path, notice: "Fourniture retirée de la liste d'achat."
  end

  private

  def set_item
    @item = current_user.liste_achat.liste_achat_items.find(params[:id])
  end

  def item_params
    params.require(:liste_achat_item).permit(:quantity)
  end
end
