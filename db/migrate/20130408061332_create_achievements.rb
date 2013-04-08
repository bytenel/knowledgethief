class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :summary

      t.timestamps
    end
  end
end
