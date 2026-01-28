class DashboardsController < ApplicationController
  def show
    @fournitures_count = current_user.fournitures.count
    @categories_count = current_user.categories.count
    @stock_bas_count = current_user.fournitures.where("quantity <= 1").count
    @a_acheter_count = current_user.liste_achat&.liste_achat_items&.count.to_i

    fournitures = current_user.fournitures

    @stock_total_value_cents =
      fournitures.where.not(price_cents: nil).sum("price_cents * quantity")

    @stock_bas_value_cents =
      fournitures.where("quantity <= 1").where.not(price_cents: nil).sum("price_cents * quantity")

    @a_acheter_value_cents =
      current_user.liste_achat&.liste_achat_items
                  &.joins(:fourniture)
                  &.where&.not(fournitures: { price_cents: nil })
                  &.sum("fournitures.price_cents * liste_achat_items.quantity") || 0

    @stock_bas = current_user.fournitures.where("quantity <= 1").order(:name).limit(5)
    @derniers_ajouts = current_user.fournitures.order(created_at: :desc).limit(5)
  end
end
