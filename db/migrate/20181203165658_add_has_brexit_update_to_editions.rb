class AddHasBrexitUpdateToEditions < ActiveRecord::Migration[5.1]
  def change
    add_column :editions, :has_brexit_update, :boolean
  end
end
