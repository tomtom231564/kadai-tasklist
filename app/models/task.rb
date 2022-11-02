class Task < ApplicationRecord
  belongs_to :user#課題に向け追加した一文
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
end
