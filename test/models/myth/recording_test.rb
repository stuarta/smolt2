require "test_helper"

class Myth::RecordingTest < ActiveSupport::TestCase
  recordings =
        { "scheduled" => { "count" => 4731, "size" => 18446753858280036917, "time" => -48121973565 },
         "livetv" => { "count" => 186, "size" => 57660497676, "time" => 146451 },
         "expireable" => { "count" => 883, "size" => 3029234372733, "time" => -1240505990 },
         "upcoming" => { "count" => 101, "time" => 337320 } }
  test "a lot of recordings" do
    recordings.each do |r_name, r_stat|
      m_recstat = Myth::Recording.create(name: r_name,
                                        count: r_stat["count"],
                                        time:  r_stat["time"])
      if r_stat.key?("size")
        m_recstat["size"] = r_stat["size"]
      end

      m_recstat.valid?
      if r_stat.key?("size") and r_stat["size"] > Myth::Recording::BIGINT_MAX
        assert m_recstat.errors[:size].any?
      end
      if r_stat["time"] < 0
        assert m_recstat.errors[:time].any?
      end
      assert m_recstat.errors[:host].any?
    end
  end
end
