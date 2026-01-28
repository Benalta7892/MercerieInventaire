class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]
  def index
    @categories = current_user.categories
                              .left_joins(:fournitures)
                              .select(<<~SQL.squish)
                                categories.*,
                                COALESCE(
                                  SUM(
                                    COALESCE(fournitures.price_cents, 0) * COALESCE(fournitures.quantity, 0)
                                  ), 0
                                ) AS total_value_cents
                              SQL
                              .group("categories.id")
                              .order(:name)
  end

  def show
    @fournitures = @category.fournitures.order(:name)

    @category_total_value_cents = @category.fournitures
                                           .where.not(price_cents: nil)
                                           .sum("price_cents * COALESCE(quantity, 0)")
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Catégorie créée avec succès."
    else
      render :new, alert: "Erreur lors de la création de la catégorie."
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to (params[:return_to].presence || categories_path), notice: "Catégorie mise à jour avec succès."
    else
      render :edit, alert: "Erreur lors de la mise à jour de la catégorie."
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Catégorie supprimée avec succès."
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
