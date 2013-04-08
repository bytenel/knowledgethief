class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.integer :user_id
      t.string :phone
      t.string :address
      t.string :summary

      t.timestamps
    end
  end
end
