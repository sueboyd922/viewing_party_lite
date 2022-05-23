class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users

  validates :email, uniqueness: true
  validates_presence_of :name, :email
  validates_presence_of :password, require: true
  validates_presence_of :password_confirmation, require: true
  validates_presence_of :password_digest, require: true

  has_secure_password

  def invited_parties
    parties.where.not(host: self.id)
  end

  def hosted_parties
    parties.where(host: self.id)
  end

end
