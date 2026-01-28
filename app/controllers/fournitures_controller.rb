class FournituresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fourniture, only: %i[show edit update destroy]
  def index
    @categories = current_user.categories.order(:name)
    @fournitures = current_user.fournitures.includes(:category).order(created_at: :desc)

    if params[:query].present?
      q = "%#{params[:query]}%"
      @fournitures = @fournitures.where("fournitures.name ILIKE ? OR fournitures.description ILIKE ?", q, q)
    end

    @fournitures = @fournitures.where(category_id: params[:category_id]) if params[:category_id].present?

    @total_value_cents = @fournitures.where.not(price_cents: nil).sum("price_cents * quantity")
  end

  def show; end

  def new
    @fourniture = current_user.fournitures.new
    @return_to = params[:return_to].presence || request.referer
  end

  def create
    @fourniture = current_user.fournitures.new(fourniture_params)
    if @fourniture.save
      redirect_to fourniture_path(@fourniture, return_to: params[:return_to]),
                  notice: "Fourniture créée avec succès."
    else
      render :new, alert: "Erreur lors de la création de la fourniture."
    end
  end

  def edit; end

  def update
    if @fourniture.update(fourniture_params)
      redirect_to fourniture_path(@fourniture, return_to: params[:return_to], origin: params[:origin]),
                  notice: "Fourniture mise à jour avec succès."
    else
      render :edit, alert: "Erreur lors de la mise à jour de la fourniture."
    end
  end

  def destroy
    @fourniture.destroy
    redirect_to fournitures_path, notice: "Fourniture supprimée avec succès."
  end

  def stock_bas
    @fournitures = current_user.fournitures.includes(:category).where("quantity <= 1").order(:name)
    @total_value_cents = @fournitures.where.not(price_cents: nil).sum("price_cents * quantity")
  end

  private

  def set_fourniture
    @fourniture = current_user.fournitures.find(params[:id])
  end

  def fourniture_params
    params.require(:fourniture).permit(:name, :quantity, :unit, :color, :price_euros, :description, :category_id)
  end
end
