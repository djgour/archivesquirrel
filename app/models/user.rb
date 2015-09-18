class User < ActiveRecord::Base
  has_secure_password
  validates :login, presence: true,
                    uniqueness: { case_sensitive: false }
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }
end
