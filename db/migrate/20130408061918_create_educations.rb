class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :resume_id
      t.string :city
      t.string :state
      t.integer :user_id
      t.string :school_name
      t.string :major
      t.string :since_year
      t.string :end_year

      t.timestamps
    end
  end
end
