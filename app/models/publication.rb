class Publication < ApplicationRecord
  belongs_to :user

  STATUSES = ['draft', 'published', 'archived']

  validates :title, presence: true
  validates :content, presence: true
  validates :status, inclusion: { in: STATUSES }
end
