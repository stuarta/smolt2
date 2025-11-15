class CreateMythDatabases < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_databases do |t|
      t.bigint :used_engine_id

      t.timestamps
    end
    add_reference :myth_databases, :db_version, null: false, foreign_key: {to_table: :myth_db_versions}

    create_table :myth_databases_db_engines, id: false do |t|
      t.belongs_to :database
      t.belongs_to :db_engine
    end

    create_table :myth_databases_schemaversions, id: false do |t|
      t.belongs_to :database
      t.belongs_to :schemaversion
    end
  end
end
