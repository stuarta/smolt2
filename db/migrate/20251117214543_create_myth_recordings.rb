class CreateMythRecordings < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_recordings do |t|
      t.string :name
      t.bigint :count
      t.bigint :size
      t.bigint :time

      t.timestamps
    end
  end
end
