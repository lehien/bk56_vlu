class Question < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140, minimum: 10 }
  validates :content, presence: true, length: { maximum: 500, minimum: 20 }

  has_many :answers, :dependent => :destroy
  
  def capitalized_title
    title.capitalize
  end
end
