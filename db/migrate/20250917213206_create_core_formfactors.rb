class CreateCoreFormfactors < ActiveRecord::Migration[8.0]
  def change
    create_table :core_formfactors do |t|
      t.string :formfactor

      t.timestamps
      t.index [:formfactor], name: "formfactor_idx", unique: true
    end
  end
end
