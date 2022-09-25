class AddUnopenedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unopened, :integer, default: 0
    add_column :users, :admin, :boolean
  end
end
