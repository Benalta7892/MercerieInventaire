class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit, alert: "Erreur lors de la mise à jour du profil."
    end
  end

  def destroy
    current_user.destroy
    redoirect_to root_path, notice: "Compte supprimé avec succès."
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
