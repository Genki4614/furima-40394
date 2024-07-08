require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it '各登録フォームへ記入ができてる場合登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'test1234'
        @user.password_confirmation = 'test12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaaa1'
        @user.password_confirmation = 'aaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英時のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と半角数字の両方を含めて設定してください')
      end
      it 'passwordが半角数字では登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英字と半角数字の両方を含めて設定してください")
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'ＡＢＣＤ１２３４'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には半角英字と半角数字の両方を含めて設定してください"
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end

      it 'first_nameに半角文字が含まれていると登録できない' do
        @user.first_name = 'ﾖｼﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name 全角文字を使用してください"
      end
      it 'last_nameに半角文字が含まれていると登録できない' do
        @user.last_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name 全角文字を使用してください"
      end
      it 'first_name_kanaにカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.first_name_kana = '吉田'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana カタカナを使用してください"
      end
      it 'last_name_kanaにカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.last_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana カタカナを使用してください"
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end