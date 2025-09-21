class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_many :items # この行を追加

  #validates :nickname, presence: true # この行を追加
  #validates :password, # この行を追加
end