class Event < ApplicationRecord
    validates :event_type, presence: true
    validates :actor_id, presence: true
    validates :repo_id, presence: true

    belongs_to :repo
end
