class CreateMythCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_countries do |t|
      t.string :country

      t.timestamps
    end
  end
end
