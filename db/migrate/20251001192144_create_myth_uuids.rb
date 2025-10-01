class CreateMythUuids < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_uuids do |t|
      t.string :myth_uuid

      t.timestamps
    end
  end
end
