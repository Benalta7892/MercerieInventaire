class AddPriceToFournitures < ActiveRecord::Migration[7.1]
  def change
    add_column :fournitures, :price_cents, :integer
  end
end
