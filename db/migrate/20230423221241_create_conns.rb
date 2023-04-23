class CreateConns < ActiveRecord::Migration[7.0]
  def change
    create_table :conns do |t|
      t.string :uuid
      t.string :author

      t.timestamps
    end
  end
end
