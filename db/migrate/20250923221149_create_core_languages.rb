class CreateCoreLanguages < ActiveRecord::Migration[8.0]
  def change
    create_table :core_languages do |t|
      t.string :language

      t.timestamps
    end
  end
end
