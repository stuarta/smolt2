class CreateStatOsFamilies < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_os_families do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
