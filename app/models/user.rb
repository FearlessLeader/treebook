class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name
  # attr_accessible :title, :body
  
  validates :first_name,   presence: true
  validates :last_name,    presence: true
  validates :profile_name, presence: true, 
                           uniqueness: true, 
                           format: { 
                             with: /^[a-zA-Z0-9_-]+$/, 
                             message: "Must be formatted correctly." 
                           }

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships

  # Creates a user full name
  def full_name
  	first_name + " " + last_name
  end
  
  def gravatar_url
    strip_down_email = email.strip.downcase
    hash = Digest::MD5.hexdigest(strip_down_email)
    "http://gravatar.com/avatar/#{hash}"
  end
end
