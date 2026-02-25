class CreateStatMythBranches < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_myth_branches do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
