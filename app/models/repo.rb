class Repo < ApplicationRecord
    has_many :events
    validates :name, presence: true
end
