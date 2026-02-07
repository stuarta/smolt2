module FilesystemBucketConcern
  extend ActiveSupport::Concern

  included do
    scope :filesystem_0_to_2Gb,       -> { where("fs_size_mb < 2048") }
    scope :filesystem_2Gb_to_100Gb,   -> { where("fs_size_mb >= 2048 AND fs_size_mb < 102400") }
    scope :filesystem_100Gb_to_200Gb, -> { where("fs_size_mb >= 102400 AND fs_size_mb < 204800") }
    scope :filesystem_200Gb_to_400Gb, -> { where("fs_size_mb >= 204800 AND fs_size_mb < 409600") }
    scope :filesystem_400Gb_to_700Gb, -> { where("fs_size_mb >= 409600 AND fs_size_mb < 716800") }
    scope :filesystem_700Gb_to_1Tb,   -> { where("fs_size_mb >= 716800 AND fs_size_mb < 1048576") }
    scope :filesystem_1Tb_to_2Tb,     -> { where("fs_size_mb >= 1048576 AND fs_size_mb < 2097152") }
    scope :filesystem_2Tb_to_4Tb,     -> { where("fs_size_mb >= 2097152 AND fs_size_mb < 4194304") }
    scope :filesystem_4Tb_to_8Tb,     -> { where("fs_size_mb >= 4194304 AND fs_size_mb < 8388608") }
    scope :filesystem_8Tb_plus,       -> { where("fs_size_mb >= 8388608") }
  end
end
