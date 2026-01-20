class CreateListeAchats < ActiveRecord::Migration[7.1]
  def change
    create_table :liste_achats do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
