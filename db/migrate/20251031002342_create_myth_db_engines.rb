class CreateMythDbEngines < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_db_engines do |t|
      t.string :engine

      t.timestamps
    end
  end
end
