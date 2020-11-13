class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name,     null: false
      t.string :action,   null: false
      t.string :resource, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
