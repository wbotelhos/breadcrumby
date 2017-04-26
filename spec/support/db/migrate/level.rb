class CreateLevelsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :levels do |t|
      t.string :name

      t.references :course, null: false, index: true, foreign_key: true
    end
  end
end
