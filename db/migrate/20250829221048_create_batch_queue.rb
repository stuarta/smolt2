class CreateBatchQueue < ActiveRecord::Migration[7.2]
  def change
    create_table :batch_queue, if_not_exists: true do |t|
      t.timestamp :arrival,   default: -> { "CURRENT_TIMESTAMP" }
      t.integer   :added,     null: false
      t.string    :hw_uuid,   null: false
      t.text      :data,      default: -> {'NULL'}
    end
  end
end
