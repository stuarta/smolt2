class CreateMythStorages < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_storages do |t|
      t.string :name
      t.bigint :size

      t.timestamps
    end
  end
end
