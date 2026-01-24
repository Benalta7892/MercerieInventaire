class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    uploaded_avatar = params.dig(:user, :avatar).present?
    remove_avatar = params[:remove_avatar] == "1"

    if @user.update(user_params)
      @user.avatar.purge if remove_avatar && !uploaded_avatar
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit, alert: "Erreur lors de la mise à jour du profil."
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "Compte supprimé avec succès."
  end

  def destroy_avatar
    current_user.avatar.purge_later
    redirect_to edit_profile_path, notice: "Avatar supprimé."
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
