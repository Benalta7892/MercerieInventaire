class Fourniture < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :liste_achat_items, dependent: :destroy

  validates :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0  }
end
