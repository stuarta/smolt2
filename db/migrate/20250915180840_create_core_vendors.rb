class CreateCoreVendors < ActiveRecord::Migration[8.0]
  def change
    create_table :core_vendors do |t|
      t.string :name

      t.timestamps
    end
  end
end
