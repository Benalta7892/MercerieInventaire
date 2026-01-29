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

    @stock_value_by_category = current_user.categories
                                           .left_joins(:fournitures)
                                           .group("categories.name")
                                           .sum("COALESCE(fournitures.price_cents, 0) * COALESCE(fournitures.quantity, 0)")
                                           .sort_by { |_name, cents| -cents }
                                           .first(8)

    @stock_value_by_category_labels = @stock_value_by_category.map { |(name, _)| name }
    @stock_value_by_category_values = @stock_value_by_category.map { |(_, cents)| (cents.to_f / 100.0) }

    @stock_total_value = current_user.fournitures.sum("COALESCE(price_cents,0) * COALESCE(quantity,0)") / 100.0

    @low_stock_total_value = current_user.fournitures
                                         .where("quantity <= 1")
                                         .sum("COALESCE(price_cents,0) * COALESCE(quantity,0)") / 100.0

    @shopping_list_total_value =
      (current_user.liste_achat&.liste_achat_items
        &.joins(:fourniture)
        &.sum("COALESCE(fournitures.price_cents,0) * COALESCE(liste_achat_items.quantity,0)") || 0) / 100.0

    fournitures = current_user.fournitures

    stock_total_cents =
      fournitures.where.not(price_cents: nil).sum("price_cents * quantity")

    stock_bas_cents =
      fournitures.where("quantity <= 1").where.not(price_cents: nil).sum("price_cents * quantity")

    stock_ok_cents = stock_total_cents - stock_bas_cents

    liste_achat_cents =
      current_user.liste_achat&.liste_achat_items
                  &.joins(:fourniture)
                  &.where&.not(fournitures: { price_cents: nil })
                  &.sum("fournitures.price_cents * liste_achat_items.quantity") || 0

    @risk_action_labels = ["Stock OK", "Stock bas", "Liste d'achat"]
    @risk_action_values = [
      (stock_ok_cents / 100.0),
      (stock_bas_cents / 100.0),
      (liste_achat_cents / 100.0)
    ]
  end
end
