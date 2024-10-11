class Cat < Pet
  TRACKER_TYPES = [ "small", "big" ]

  validates :tracker_type, inclusion: { in: TRACKER_TYPES }, allow_nil: true
end
