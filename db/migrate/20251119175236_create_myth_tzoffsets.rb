class CreateMythTzoffsets < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_tzoffsets do |t|
      t.string :tzoffset

      t.timestamps
    end
  end
end
