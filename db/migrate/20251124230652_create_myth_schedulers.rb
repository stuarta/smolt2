class CreateMythSchedulers < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_schedulers do |t|
      t.bigint :count
      t.float :match_avg
      t.float :match_stddev
      t.float :place_avg
      t.float :place_stddev

      t.belongs_to :host

      t.timestamps
    end
  end
end
