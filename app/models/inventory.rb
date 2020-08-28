class Inventory < ApplicationRecord
    validates :capacity, presence: true
    belongs_to :survivor
    has_many :items
end
