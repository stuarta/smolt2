class CreateMythVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_versions do |t|
      t.string :version

      t.timestamps
    end
  end
end
