class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :resume_id
      t.integer :user_id
      t.string :institute_name
      t.string :city
      t.string :state
      t.string :since_year
      t.string :end_year
      t.string :title
      t.string :summary

      t.timestamps
    end
  end
end
