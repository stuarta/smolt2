class CreateMythHistoricals < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_historicals do |t|
      t.bigint :db_age
      t.bigint :rectime
      t.bigint :reccount
      t.bigint :showcount

      t.timestamps
    end
  end
end
