class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.string :name
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :actions, :name, unique: true
  end
end
