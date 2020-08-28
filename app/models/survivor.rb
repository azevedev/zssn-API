class Survivor < ApplicationRecord
    validates :name, presence: true
    validates :age, presence: true
    validates :gender, presence: true
    
    has_one :location
    has_one :inventory
end
