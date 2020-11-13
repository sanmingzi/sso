class CreateRolesPermissions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :roles, :permissions, table_name: :roles_permissions do |t|
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
