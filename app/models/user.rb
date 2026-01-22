class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :fournitures, dependent: :destroy
  has_one :liste_achat, dependent: :destroy

  after_create :initialize_liste_achat

  private

  def initialize_liste_achat
    create_liste_achat unless liste_achat
  end
end
