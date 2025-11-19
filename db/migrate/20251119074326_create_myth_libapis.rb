class CreateMythLibapis < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_libapis do |t|
      t.string :libapi

      t.timestamps
    end
  end
end
