class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.boolean :status, null: false, default: true
      t.timestamps
    end
  end
end
