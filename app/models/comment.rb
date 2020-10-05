class Comment < ApplicationRecord
    belongs_to :commenter, class_name: "Musician", foreign_key: :commenter_id
    belongs_to :commentee, class_name: "Musician", foreign_key: :commentee_id

end
