class CreateMythQtVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_qt_versions do |t|
      t.string :qt_version

      t.timestamps
    end
  end
end
