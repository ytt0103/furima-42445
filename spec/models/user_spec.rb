require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての条件が満たされていれば登録できる' do
        # すでに before で @user が完璧な状態でビルドされているため、そのまま検証します。
        expect(user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = '' 
        user.valid?
        expect(user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include("Eメールを入力してください")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save # 1人目（@user）をデータベースに保存
        # 2人目（user_with_same_email）を作成し、1人目と同じメールアドレスを設定
        user_with_same_email = FactoryBot.build(:user, email: @user.email)
        user_with_same_email.valid? # 2人目のバリデーションを実行
        expect(user_with_same_email.errors.full_messages).to include("Eメールはすでに存在します")
      end


      it 'emailに@を含まないと登録できない' do
        @user.email = 'testexample.com'
        user.valid?
        expect(user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下だと登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        user.valid?
        expect(user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが英字のみだと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordが数字のみだと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordに全角文字が含まれていると登録できない' do
        @user.password = 'パスワード１２３'
        @user.password_confirmation = 'パスワード１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordとpassword_confirmationが不一致だと登録できない' do
        @user.password_confirmation = 'mismatch'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'riku'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください")
      end

      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください")
      end

      it 'last_name_kanaが全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角（カタカナ）で入力してください")
      end

      it 'first_name_kanaが全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角（カタカナ）で入力してください")
      end

      it 'birth_dateが空だと登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end