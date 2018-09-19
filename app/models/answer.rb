class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  # validates :question_accepted_id, uniqueness: true
  has_many :votes, dependent: :destroy
  include PgSearch
  multisearchable :against => [:body]
  pg_search_scope :search_by_body, :against => :body

  def score
    votes.map {|vote| vote.value}.inject(:+) || 0
  end

  def accepted?
    !!question_accepted_id
  end
end
