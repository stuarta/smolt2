module StorageConcern
  extend ActiveSupport::Concern

  included do
    scope :recfree,     -> { where(name: "recfree") }
    scope :rectotal,    -> { where(name: "rectotal") }
    scope :videofree,   -> { where(name: "videofree") }
    scope :videototal,  -> { where(name: "videototal") }
    scope :nonzero,     -> { where("size != 0") }
  end
end
