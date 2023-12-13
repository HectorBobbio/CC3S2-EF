class User < ActiveRecord::Base
  validates :username, :presence => true
  # validate :username_format
  validate :username_format

  def username_format
    if username.length > 10
      errors.add(:username, "cant be longer than 10 characters")
    end

    if !username.match(/^[a-zA-Z]/)
      errors.add(:username, "must start with a letter")
    end
  end
end
