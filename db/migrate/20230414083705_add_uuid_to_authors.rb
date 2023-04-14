class AddUuidToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors,  :uuid, :string
  end
end
