class CreateCorePlatforms < ActiveRecord::Migration[8.0]
  def change
    create_table :core_platforms do |t|
      t.string :platform

      t.timestamps
      t.index [ :platform ], name: "platform_idx", unique: true
    end
  end
end
