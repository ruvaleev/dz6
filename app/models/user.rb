class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :commentable, source_type: :Post
  has_many :commented_users, through: :comments, source: :commentable, source_type: :User

  validates :name, :email, presence: true
  validates :name, length: { maximum: 16, minimum: 2 }
  validates :name, :email, uniqueness: true

  before_destroy :log_before_destory
  after_destroy :log_after_destory

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
