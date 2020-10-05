class Relationship < ApplicationRecord
    belongs_to :followed, class_name: "Musician", foreign_key: :followed_id
    belongs_to :follower, class_name: "Musician", foreign_key: :follower_id
    
    
end
