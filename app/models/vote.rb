class Vote < ApplicationRecord
  validates :value, inclusion: { in: [1,0,-1],
    message: "value must be 1, 0, or -1" } , allow_nil: true
  belongs_to :user
  belongs_to :answer
end
