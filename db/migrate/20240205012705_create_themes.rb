# frozen_string_literal: true

class CreateThemes < ActiveRecord::Migration[7.1]
  def change
    create_table :themes do |t|
      t.string :name
      t.string :theme_type
      t.boolean :premium
      t.string :css_value

      t.timestamps
    end
  end
end
