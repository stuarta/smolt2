class CreateCoreVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :core_vendors do |t|
      t.string :name

      t.timestamps
      t.index [ :name ], name: "vendors_idx", unique: true
    end
  end
end
