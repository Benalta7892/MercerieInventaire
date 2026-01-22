class ListeAchatsController < ApplicationController
  before_action :authenticate_user!
  def show
    @liste_achat = current_user.liste_achat || current_user.create_liste_achat
    @items = @liste_achat.liste_achat_items.includes(:fourniture).order(created_at: :desc)
  end
end
