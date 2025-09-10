class CreateCorePlatforms < ActiveRecord::Migration[8.0]
  def change
    create_table :core_platforms do |t|
      t.text :platform

      t.timestamps
    end
  end
end
