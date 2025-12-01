class AddMythHostToCoreHost < ActiveRecord::Migration[8.0]
  def change
    add_reference :core_hosts, :myth_host, null: false, foreign_key: true
  end
end
