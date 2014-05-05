class Weight < ActiveRecord::Base
  belongs_to :user

  validates :date,
    presence: true
  validates :weight,
    presence: true,
    numericality: { greater_than: 0 }
  validates :user_id,
    presence: true,
    uniqueness: { scope: :date }
end
