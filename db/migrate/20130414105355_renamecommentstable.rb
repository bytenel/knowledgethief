class Renamecommentstable < ActiveRecord::Migration
  def change
    rename_table :comments, :rcomments
  end
end
