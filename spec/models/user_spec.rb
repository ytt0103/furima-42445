require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての条件が満たされていれば登録できる' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        user = FactoryBot.build(:user, nickname: '')
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空だと登録できない' do
        user = FactoryBot.build(:user, email: '')
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        user = FactoryBot.build(:user, email: @user.email)
        user.valid?
        expect(user.errors.full_messages).to include("Email has already been taken")
      end

      it 'emailに@を含まないと登録できない' do
        user = FactoryBot.build(:user, email: 'testexample.com')
        user.valid?
        expect(user.errors.full_messages).to include("Email is invalid")
      end

      it 'passwordが空だと登録できない' do
        user = FactoryBot.build(:user, password: '')
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下だと登録できない' do
        user = FactoryBot.build(:user, password: '12345')
        user.valid?
        expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが英字のみだと登録できない' do
        user = FactoryBot.build(:user, password: 'abcdef')
        user.valid?
        expect(user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it 'passwordが数字のみだと登録できない' do
        user = FactoryBot.build(:user, password: '123456')
        user.valid?
        expect(user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it 'last_nameが空だと登録できない' do
        user = FactoryBot.build(:user, last_name: '')
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが空だと登録できない' do
        user = FactoryBot.build(:user, first_name: '')
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        user = FactoryBot.build(:user, last_name: 'yamada')
        user.valid?
        expect(user.errors.full_messages).to include("Last name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        user = FactoryBot.build(:user, first_name: 'riku')
        user.valid?
        expect(user.errors.full_messages).to include("First name は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'last_name_kanaが空だと登録できない' do
        user = FactoryBot.build(:user, last_name_kana: '')
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが空だと登録できない' do
        user = FactoryBot.build(:user, first_name_kana: '')
        user.valid?
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'last_name_kanaが全角（カタカナ）でないと登録できない' do
        user = FactoryBot.build(:user, last_name_kana: 'やまだ')
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana は全角（カタカナ）で入力してください")
      end

      it 'first_name_kanaが全角（カタカナ）でないと登録できない' do
        user = FactoryBot.build(:user, first_name_kana: 'りくたろう')
        user.valid?
        expect(user.errors.full_messages).to include("First name kana は全角（カタカナ）で入力してください")
      end

      it 'birth_dateが空だと登録できない' do
        user = FactoryBot.build(:user, birth_date: nil)
        user.valid?
        expect(user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end