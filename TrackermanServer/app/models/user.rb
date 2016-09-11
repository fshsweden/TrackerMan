class User < ActiveRecord::Base

  before_create :generate_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def generate_authentication_token
    loop do
      self.token = SecureRandom.base64(64)
      break unless User.find_by(token: token)
    end
  end

end
