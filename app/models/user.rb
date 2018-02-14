class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
  has_many :commented_users, through: :comments, source: :commentable, source_type: :User

  validates :name, :email, presence: true
  validates :name, length: { maximum: 16, minimum: 2 }
  validates :name, :email, uniqueness: true

  before_destroy :log_before_destory
  after_destroy :log_after_destory

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def log_before_destory
    Rails.logger.info '#########################################'
    Rails.logger.info "Перед удалением пользователя #{@name}"
    Rails.logger.info '#########################################'
  end

  def log_after_destory
    Rails.logger.info '#########################################'
    Rails.logger.info "После удаления пользователя #{@name}"
    Rails.logger.info '#########################################'
  end
end
