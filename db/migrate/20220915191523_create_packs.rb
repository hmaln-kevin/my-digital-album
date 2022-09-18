class CreatePacks < ActiveRecord::Migration[5.2]
  def change
    create_table :packs do |t|
      t.references :figure, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
