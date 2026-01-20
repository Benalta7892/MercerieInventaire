class CreateListeAchatItems < ActiveRecord::Migration[7.1]
  def change
    create_table :liste_achat_items do |t|
      t.decimal :quantity
      t.references :liste_achat, null: false, foreign_key: true
      t.references :fourniture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
