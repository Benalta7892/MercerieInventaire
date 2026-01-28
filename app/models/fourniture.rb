class Fourniture < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :liste_achat_items, dependent: :destroy

  validates :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def stock_value_cents
    return 0 if price_cents.blank? || quantity.blank?

    (price_cents * quantity.to_i)
  end

  def stock_value_euros
    stock_value_cents / 100.0
  end

  def price_euros
    price_cents.present? ? price_cents / 100.0 : nil
  end

  def price_euros=(value)
    self.price_cents = (value.to_f * 100).round
  end
end
