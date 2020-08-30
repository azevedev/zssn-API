class Location < ApplicationRecord
    belongs_to :survivor
    validates :capacity, presence: true
end
