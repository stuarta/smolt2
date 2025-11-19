class CreateMythBranches < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_branches do |t|
      t.string :branch

      t.timestamps
    end
  end
end
