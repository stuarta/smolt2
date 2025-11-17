class CreateMythPlaybackProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_playback_profiles do |t|
      t.string :profile_name

      t.timestamps
    end
    create_table :myth_playback_profile_details_profiles, id: false do |t|
      t.belongs_to :playback_profile
      t.belongs_to :playback_profile_detail
    end
  end
end
