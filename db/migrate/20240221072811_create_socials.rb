class CreateSocials < ActiveRecord::Migration[7.1]
  def change
    create_table :socials do |t|
      t.string :name
      t.string :url
      t.boolean :active
      t.integer :position
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
