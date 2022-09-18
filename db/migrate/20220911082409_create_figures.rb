class CreateFigures < ActiveRecord::Migration[5.2]
  def change
    create_table :figures do |t|
      t.string :name
      t.string :rarity
      t.string :description
      t.string :picture
      t.string :code

      t.timestamps
    end
  end
end
