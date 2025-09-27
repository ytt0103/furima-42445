class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  
  with_options presence: true do
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角（漢字・ひらがな・カタカナ）で入力してください" }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角（漢字・ひらがな・カタカナ）で入力してください" }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角（カタカナ）で入力してください" }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角（カタカナ）で入力してください" }
    validates :birth_date
  end

  # パスワードのバリデーション（Deviseのデフォルト設定を上書き）
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: "には英字と数字の両方を含めて設定してください", on: :create
end