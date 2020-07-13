class User < ApplicationRecord
  mount_uploader :image, ImageUploader  
  has_secure_password validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, unless: -> { validation_context == :facebook_login }

  
  has_many :books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  

  def self.from_omniauth(auth)
    #emailの提供は必須とする
    user = User.where("email = ?", auth.info.email).first
    if user.blank?
      user = User.new
    end
    user.uid = auth.id
    user.name = auth.info.name
    user.email = auth.info.email
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user
  end
end
