class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
