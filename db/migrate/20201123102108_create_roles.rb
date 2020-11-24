class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, index: {unique: true}, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
