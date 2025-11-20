class CreateMythAudios < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_audios do |t|
      t.string  :audio_sys
      t.string  :audio_sys_version
      t.integer :defaultupmix
      t.string  :device
      t.integer :jack
      t.integer :maxchannels
      t.string  :mixercontrol
      t.string  :mixerdevice
      t.string  :passthru
      t.string  :passthrudevice
      t.integer :passthruoverride
      t.integer :pulse
      t.integer :sr_override
      t.integer :stereopcm
      t.string  :upmixtype
      t.integer :volcontrol

      t.belongs_to :host

      t.timestamps
    end
  end
end
