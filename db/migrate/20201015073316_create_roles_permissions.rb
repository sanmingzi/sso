class CreateRolesPermissions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :roles, :permissions do |t|
    end
  end
end
