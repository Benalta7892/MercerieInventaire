class CreateFournitures < ActiveRecord::Migration[7.1]
  def change
    create_table :fournitures do |t|
      t.string :name
      t.decimal :quantity
      t.string :unit
      t.string :color
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
