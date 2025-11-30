class Myth::Recording < ApplicationRecord
  BIGINT_MAX = 9223372036854775807.freeze
  validates_numericality_of :size, greater_than: 0,  less_than_or_equal_to: BIGINT_MAX
  validates_numericality_of :time, greater_than: 0,  less_than_or_equal_to: BIGINT_MAX

  belongs_to :host
end
