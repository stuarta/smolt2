class CreateMythHosts < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_hosts do |t|
      t.integer     :channelcount
      t.integer     :sourcecount
      t.float       :vtpertuner
      t.timestamp   :arrival

      t.belongs_to  :uuid

      t.belongs_to  :branch
      t.belongs_to  :country
      t.belongs_to  :historical
      t.belongs_to  :language
      t.belongs_to  :libapi
      t.belongs_to  :protocol
      t.belongs_to  :theme
      t.belongs_to  :timezone
      t.belongs_to  :tzoffset
      t.belongs_to  :remote
      t.belongs_to  :qt_version
      t.belongs_to  :version
      t.belongs_to  :version_bucket

      t.timestamps
    end

    create_table :myth_grabbers_hosts, id: false do |t|
      t.belongs_to :grabber
      t.belongs_to :host
    end
  end
end
