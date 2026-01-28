class ListeAchatsController < ApplicationController
  before_action :authenticate_user!
  def show
    @liste_achat = current_user.liste_achat || current_user.create_liste_achat
    @items = @liste_achat.liste_achat_items.includes(:fourniture).order(created_at: :desc)

    @total_value_cents = @items
                         .joins(:fourniture)
                         .where.not(fournitures: { price_cents: nil })
                         .sum("fournitures.price_cents * liste_achat_items.quantity")
  end
end
