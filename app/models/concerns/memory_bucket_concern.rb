module MemoryBucketConcern
  extend ActiveSupport::Concern

  included do
    scope :memory_0_to_2Gb,    -> { where("system_memory < 2048") }
    scope :memory_2_to_4Gb,    -> { where("system_memory >= 2048 AND system_memory < 4096") }
    scope :memory_4_to_8Gb,    -> { where("system_memory >= 4096 AND system_memory < 8192") }
    scope :memory_8_to_16Gb,   -> { where("system_memory >= 8192 AND system_memory < 16384") }
    scope :memory_16_to_32Gb,  -> { where("system_memory >= 16384 AND system_memory < 32768") }
    scope :memory_32_to_64Gb,  -> { where("system_memory >= 32768 AND system_memory < 65536") }
    scope :memory_64_to_128Gb, -> { where("system_memory >= 65536 AND system_memory < 131072") }
    scope :memory_128Gb_plus,  -> { where("system_memory >= 131072") }
  end
end
