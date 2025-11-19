class CreateMythLanguages < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_languages do |t|
      t.string :language

      t.timestamps
    end
  end
end
