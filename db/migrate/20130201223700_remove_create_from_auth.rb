class RemoveCreateFromAuth < ActiveRecord::Migration
  def up
    remove_column :authentications, :create
    remove_column :authentications, :index
  end

  def down
  end
end