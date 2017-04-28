# frozen_string_literal: true

class CreateSchoolsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
    end
  end
end
