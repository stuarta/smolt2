class CreateMythPlaybackProfileDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_playback_profile_details do |t|
      t.string :decoder
      t.string :deint_pri
      t.string :deint_sec
      t.string :renderer
      t.string :filters

      t.timestamps
    end
  end
end
