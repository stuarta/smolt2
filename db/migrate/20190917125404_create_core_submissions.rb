class CreateCoreSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :core_submissions do |t|
      t.datetime  :arrival,   default: -> {'CURRENT_TIMESTAMP'}
      t.boolean   :added,     default: false
      t.string    :hw_uuid,   null: false
      t.text      :data,      null: false

      t.timestamps
    end
  end
end
