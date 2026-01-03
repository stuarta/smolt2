module RecentConcern
  extend ActiveSupport::Concern

  included do
    scope :recent, -> {
      where("updated_at >= ?", Date.today - 90)
    }
  end
end
