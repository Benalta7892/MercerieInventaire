class DashboardsController < ApplicationController
  def show
    @fournitures_count = current_user.fournitures.count
    @categories_count = current_user.categories.count
    @stock_bas_count = current_user.fournitures.where("quantity <= 1").count
    @a_acheter_count = current_user.liste_achat&.liste_achat_items&.count.to_i

    @stock_bas = current_user.fournitures.where("quantity <= 1").order(:name).limit(5)
    @derniers_ajouts = current_user.fournitures.order(created_at: :desc).limit(5)
  end
end
