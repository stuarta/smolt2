class CreateCoreHostPubMappings < ActiveRecord::Migration[5.2]
  def change
    create_table :core_host_pub_mappings do |t|
      t.string      :uuid,      null: false
      t.string      :pub_uuid,  null: false

      t.timestamps
    end
    add_index :core_host_pub_mappings,
      [:uuid, :pub_uuid],
      unique: true,
      name: "idx_host_pub"
  end
end
