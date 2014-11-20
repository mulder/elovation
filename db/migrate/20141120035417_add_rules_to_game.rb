class AddRulesToGame < ActiveRecord::Migration
  def change
    add_column :games, :rules, :text
  end
end
