class Pet < ApplicationRecord
  self.inheritance_column = :pet_type

  PET_TYPES = [ "Cat", "Dog" ].freeze

  validates :pet_type, inclusion: { in: PET_TYPES }
end
