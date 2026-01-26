class Admin::UsersController < ApplicationController
  before_action :require_admin!
  before_action :set_user, only: %i[show update destroy]
  def index
    @users = User.order(created_at: :desc)
  end

  def show; end

  def update
    return redirect_to admin_users_path, alert: "Action impossible." if @user == current_user

    blocked = ActiveModel::Type::Boolean.new.cast(params[:blocked])
    @user.update!(blocked: blocked)
    redirect_to admin_users_path(@user), notice: "Utilisateur mis à jour."
  end

  def destroy
    return redirect_to admin_users_path, alert: "Action impossible." if @user == current_user

    @user.destroy!
    redirect_to admin_users_path, notice: "Utilisateur supprimé."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
