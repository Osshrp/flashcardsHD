class Block < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

  def current?
    id == user.current_block_id
  end
end
