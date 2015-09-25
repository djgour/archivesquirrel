class User < ActiveRecord::Base
  has_secure_password
  validates :login, presence: true,
                    format: /\A(?=[a-z])[a-z\d_]+\Z/i,
                    uniqueness: { case_sensitive: false }

  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

  has_many :projects
end
