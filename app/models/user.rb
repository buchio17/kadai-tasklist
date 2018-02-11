class User < ApplicationRecord
  before_save {self.mail.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :mail, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :tasks
end