class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true

      t.timestamps
    end
  end
end
