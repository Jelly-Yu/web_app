class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :points
  validates :name,  presence: true
  validates :password,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  
  def self.authenticate(user_info)
      find_by_email_and_password(user_info[:email],
                      user_info[:password])
  end

  def  add_point     
	self.points += 50
	self.save
  end

  def self.get_user(u_id)
    find_by_id(u_id)
  end

end
