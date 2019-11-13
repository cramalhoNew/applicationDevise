class User < ApplicationRecord
  has_secure_password
  has_person_name
  has_one_attached :avatar

  has_many :user_roles
  has_many :roles, through: :user_roles
  before_save { email.downcase!; name.strip!; email.strip! }
  before_create :set_activation_token

  def add_role(role)
    case role
    when Symbol
      roles << Role.find_by!(name: role.to_s)
    when String
      roles << Role.find_by!(name: role.capitalize)
    else
      roles << role
    end
  end

  # returns true if the use has the provided role. If :any, returns true if the user has at least one
  def has_role?(role)
    if role.to_s == "any"
      roles.any?
    else
      !!roles.find_by(name: role.to_s)
    end
  end

  private

    def set_activation_token
      self.activation_token = SecureRandom.urlsafe_base64(15).tr("lIO0", "sxyz")
    end
end
