class AddUserIdToAchievement < ActiveRecord::Migration
  def change
    add_column :achievements, :user_id, :integer
    add_column :achievements, :resume_id, :integer
  end
end
