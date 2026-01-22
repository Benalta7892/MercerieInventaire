class DashboardsController < ApplicationController
  def show
    @fournitures_count = current_user.fournitures.count
    @categories_count = current_user.categories.count
    @stock_bas_coount = current_user.fournitures.where("quantity <= 1").count
  end
end
