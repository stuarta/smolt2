class AddTimestampsToMythGrabbersHosts < ActiveRecord::Migration[8.1]
  def up
    add_timestamps :myth_grabbers_hosts, null: true
    add_column :myth_grabbers_hosts, :id, :primary_key

    # Backfill existing records with created_at and updated_at values
    execute "UPDATE myth_grabbers_hosts
              INNER JOIN myth_hosts ON myth_grabbers_hosts.host_id = myth_hosts.id
              SET myth_grabbers_hosts.created_at = myth_hosts.created_at, myth_grabbers_hosts.updated_at = myth_hosts.updated_at;"

    # Change the columns to not allow null values
    change_column_null :myth_grabbers_hosts, :created_at, false
    change_column_null :myth_grabbers_hosts, :updated_at, false
  end
  def down
    remove_timestamps :myth_grabbers_hosts
    remove_column :myth_grabbers_hosts, :id
  end
end
