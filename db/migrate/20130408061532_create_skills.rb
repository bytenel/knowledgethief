class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :resume_id
      t.integer :user_id
      t.string :name
      t.string :summary

      t.timestamps
    end
  end
end
