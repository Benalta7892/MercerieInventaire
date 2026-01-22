class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = current_user.categories.order(:name)
  end

  def show; end

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
      redirect_to category_path(@category), notice: "Catégorie mise à jour avec succès."
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
