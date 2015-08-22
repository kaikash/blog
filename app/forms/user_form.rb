# User.where("(username = :login OR email = :login) AND password = :password", 
#       {login: session_params[:login], passoword: pass}).first

class UserForm
  include SimpleFormObject
  include BCrypt

  attribute :password, :string
  attribute :login, :string

  validates_presence_of :login, :password
  validates :password, presence: true, length: {in: 6..255}
  validates :login, presence: true, length: {in: 6..255}

  def save
    return false unless valid?
    user = User.where("(username = :login OR email = :login)", 
      {login: @login}).first

    unless !user.nil? && user.password == @password 
      return false
    end
    return user
  end
end