class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home mentions_legales confidentialite]

  def home
    redirect_to dashboard_path if user_signed_in?
  end

  def mentions_legales; end

  def confidentialite; end
end
