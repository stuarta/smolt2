class CreateMythDbVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_db_versions do |t|
      t.string :version

      t.timestamps
    end
  end
end
