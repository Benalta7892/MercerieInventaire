class ListeAchatsController < ApplicationController
  before_action :authenticate_user!
  def show
    @liste_achat = current_user.liste_achats
    @items = @liste_achat.items.includes(:fourniture).order(created_at: :desc)
  end
end
