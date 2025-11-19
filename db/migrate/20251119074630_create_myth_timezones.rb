class CreateMythTimezones < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_timezones do |t|
      t.string :timezone

      t.timestamps
    end
  end
end
