class Dog < Pet
  TRACKER_TYPES = [ "small", "medium", "big" ].freeze

  validates :tracker_type, inclusion: { in: TRACKER_TYPES }, allow_nil: true
  validate :validate_lost_tracker

  def validate_lost_tracker
    errors.add(:lost_tracker, message: "attribute not supported") unless lost_tracker.nil?
  end
end
