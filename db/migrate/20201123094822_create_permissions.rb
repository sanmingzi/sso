class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.references :action
      t.references :resource
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :permissions, [:action_id, :resource_id], unique: true
  end
end
