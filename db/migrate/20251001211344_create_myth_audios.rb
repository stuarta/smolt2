class CreateMythAudios < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_audios do |t|
      t.string :passthru
      t.integer :stereopcm
      t.string :upmixtype
      t.integer :volcontrol
      t.integer :defaultupmix
      t.integer :passthruoverride
      t.string :mixercontrol
      t.integer :sr_override
      t.string :passthrudevice
      t.string :device
      t.string :mixerdevice
      t.string :audio_sys
      t.string :audio_sys_version
      t.integer :jack
      t.integer :pulse

      t.timestamps
    end
  end
end
