class CreateMythThemes < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_themes do |t|
      t.string :theme

      t.timestamps
    end
  end
end
