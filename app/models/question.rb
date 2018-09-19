class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_one :accepted_answer, :foreign_key => "question_accepted_id", :class_name => "Answer", dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  include PgSearch
  multisearchable :against => [:title, :body]
  pg_search_scope :search_by_body, :against => :body
  pg_search_scope :search_by_title, :against => :title

  def has_accepted_answer?
    !!accepted_answer
  end
end
