class CreateStatMythCountries < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_myth_countries do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
