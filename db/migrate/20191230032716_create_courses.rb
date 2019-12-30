class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :short_name, null: false, unique: true
      t.string :name, null: false, unique: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
