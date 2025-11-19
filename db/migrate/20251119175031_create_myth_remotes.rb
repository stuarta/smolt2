class CreateMythRemotes < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_remotes do |t|
      t.string :remote

      t.timestamps
    end
  end
end
