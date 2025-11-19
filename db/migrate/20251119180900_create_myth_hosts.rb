class CreateMythHosts < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_hosts do |t|
      t.integer     :channelcount
      t.integer     :sourcecount
      t.float       :vtpertuner

      t.belongs_to  :branch
      t.belongs_to  :language
      t.belongs_to  :libapi
      t.belongs_to  :theme
      t.belongs_to  :timezone
      t.belongs_to  :country
      t.belongs_to  :version
      t.belongs_to  :version_bucket
      t.belongs_to  :qt_version
      t.belongs_to  :remote
      t.belongs_to  :protocol
      t.belongs_to  :tzoffset

      t.timestamps
    end
  end
end
