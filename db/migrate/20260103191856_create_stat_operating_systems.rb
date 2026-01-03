class CreateStatOperatingSystems < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_operating_systems do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
