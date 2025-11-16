class CreateMythGrabbers < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_grabbers do |t|
      t.string :grabber

      t.timestamps
    end
  end
end
