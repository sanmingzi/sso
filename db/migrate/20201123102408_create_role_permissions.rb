class CreateRolePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :role_permissions do |t|
      t.references :role
      t.references :permission
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :role_permissions, [:role_id, :permission_id], unique: true
  end
end
