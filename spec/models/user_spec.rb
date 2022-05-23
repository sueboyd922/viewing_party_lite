require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users)}
    it { should have_many(:parties).through(:party_users)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    subject { User.new(name: "Sherman")}
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }

    it 'secures password' do
      user = User.create!(name: 'Sherman', email: "sherman@test.com", password: "mysecret", password_confirmation: "mysecret")

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq("mysecret")
    end
  end
end
