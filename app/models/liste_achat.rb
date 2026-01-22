class ListeAchat < ApplicationRecord
  belongs_to :user
  has_many :liste_achat_items, dependent: :destroy
  has_many :fournitures, through: :liste_achat_items
end
