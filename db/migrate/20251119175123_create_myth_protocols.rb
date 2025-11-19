class CreateMythProtocols < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_protocols do |t|
      t.string :protocol

      t.timestamps
    end
  end
end
