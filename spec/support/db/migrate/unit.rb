# frozen_string_literal: true

class CreateUnitsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :name

      t.references :school, null: false, index: true, foreign_key: true
    end
  end
end
