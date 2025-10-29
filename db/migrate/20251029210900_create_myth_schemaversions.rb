class CreateMythSchemaversions < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_schemaversions do |t|
      t.string :name
      t.integer :version

      t.timestamps
    end
  end
end
