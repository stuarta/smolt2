class CreateMythTuners < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_tuners do |t|
      t.string :name
      t.integer :tuner_number

      t.timestamps
    end
  end
end
