class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, presence: true # この行をコメントアウト
  validates :email, presence: true, uniqueness: { case_sensitive: false } # この行を追加
  validates :password, length: { minimum: 6 } # この行を追加
  validates :nickname, presence: true # この行を追加
end