class AddIconsToSocials < ActiveRecord::Migration[7.1]
  def change
    add_column :socials, :icon, :string
  end
end
