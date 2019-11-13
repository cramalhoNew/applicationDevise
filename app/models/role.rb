class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  enum groups: { staff: 0, partner: 1 }

  before_validation { name.strip! }
end
