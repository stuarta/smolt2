class AddMythHostToCoreHosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :core_hosts, :myth_host, null: false
  end
end
