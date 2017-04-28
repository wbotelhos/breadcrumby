# frozen_string_literal: true

class CreateGradesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.string :name

      t.references :level, null: false, index: true, foreign_key: true
      t.references :unit, null: false, index: true, foreign_key: true
    end
  end
end
