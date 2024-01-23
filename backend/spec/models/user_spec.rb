require 'rails_helper'

RSpec.describe User do
  let(:user) { FactoryBot.build(:user) }

  it '有効なファクトリを持つこと' do
    expect(user).to be_valid
  end

  describe 'validation' do
    context 'name' do
      it '登録可能' do
        expect(user).to be_valid
        expect(user.name).to be_present
      end

      it 'nilの場合エラー' do
        u = FactoryBot.build(:user, name: nil)
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:name).first).to eq('ユーザ名を入力してください')
      end

      it '空の場合エラー' do
        u = FactoryBot.build(:user, name: '')
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:name).first).to eq('ユーザ名を入力してください')
      end

      it 'nameが51文字以上の場合エラー' do
        u = FactoryBot.build(:user, name: 'あ' * 51)
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:name).first).to eq('ユーザ名は50文字以内で入力してください')
      end
    end

    context 'email' do
      it '登録可能' do
        expect(user).to be_valid
        expect(user.email).to be_present
      end

      it '重複したメールアドレスは登録不可' do
        FactoryBot.create(:user, email: 'neumann@neumann.com')
        u = FactoryBot.build(:user, email: 'neumann@neumann.com')
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:email).first).to eq('メールアドレスは登録済みです')
      end

      it '不正な形式は登録不可' do
        u = FactoryBot.build(:user, email: 'neumannneumann.com')
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:email).first).to eq('メールアドレスは不正な値です')
      end

      it 'nilの場合エラー' do
        u = FactoryBot.build(:user, email: nil)
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:email).first).to eq('メールアドレスを入力してください')
      end

      it '空の場合エラー' do
        u = FactoryBot.build(:user, email: '')
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:email).first).to eq('メールアドレスを入力してください')
      end

      it 'emailが256文字以上の場合エラー' do
        u = FactoryBot.build(:user, email: 'あ' * 256)
        expect(u).not_to be_valid
        expect(u.errors.full_messages_for(:email).first).to eq('メールアドレスは255文字以内で入力してください')
      end
    end

    context 'password' do
      it '登録可能' do
        user_created = FactoryBot.create(:user)
        expect(user_created).to be_valid
        expect(user_created.password).to be_present
      end

      it '8文字の場合エラー' do
        expect { FactoryBot.create(:user, password: '1234567') }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message).to eq 'バリデーションに失敗しました: パスワードは8文字以上で入力してください'
        end)
      end

      it '確認用パスワードが異なる場合エラー' do
        expect { FactoryBot.create(:user, password: '12345678', password_confirmation: '12345679') }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message).to eq 'バリデーションに失敗しました: 確認用パスワードとパスワードの入力が一致しません'
        end)
      end

      it '73文字以上の場合エラー' do
        expect { FactoryBot.create(:user, password: 'a' * 73) }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message).to eq 'バリデーションに失敗しました: パスワードは72文字以内で入力してください'
        end)
      end

      it '不正な形式は登録不可' do
        expect { FactoryBot.create(:user, password: '@{}$$%%&&[]') }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message).to eq 'バリデーションに失敗しました: パスワードは半角英数字、ハイフン、アンダーバーで入力してください'
        end)
      end

      it 'nilの場合エラー' do
        expect { FactoryBot.create(:user, password: nil) }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message.split(',').first).to eq 'バリデーションに失敗しました: パスワードを入力してください'
        end)
      end

      it '空の場合エラー' do
        expect { FactoryBot.create(:user, password: '') }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message.split(',').first).to eq 'バリデーションに失敗しました: パスワードを入力してください'
        end)
      end

      it '取り出したユーザのパスワードが空でも他のカラム値を更新可能' do
        user = FactoryBot.create(:user)
        # has_secure_passwordの仕様
        # create時のインスタンスはpassword空でもカラム値の更新が可能
        user_searched = described_class.find(user.id)

        user_searched.update!(name: 'hiroki')
        expect(user_searched.name).to eq('hiroki')
      end
    end
  end

  describe 'methods' do
    let(:user_created) { FactoryBot.create(:user) }

    context 'generate_refresh_token' do
      it 'JWTリフレッシュトークンの発行' do
        refresh_token = user_created.generate_refresh_token
        expect(refresh_token.token).to be_present
      end
    end

    context 'decode_refresh_token' do
      it '復号化されたリフレッシュトークンが返る' do
        refresh_token = user_created.generate_refresh_token
        token = refresh_token.token
        decoded_refresh_token = described_class.decode_refresh_token(token)
        expect(decoded_refresh_token['sub']).to be_present
      end
    end

    context 'from_refresh_token' do
      it 'リフレッシュトークンから持ち主のユーザを取り出す' do
        refresh_token = user_created.generate_refresh_token
        token = refresh_token.token
        user_searched = described_class.from_refresh_token(token)

        expect(user_searched.id).to eq(user_created.id)
      end

      context '異常系' do
        it 'token_versionがDBと異なる場合、例外処理発生' do
          refresh_token = user_created.generate_refresh_token
          token = refresh_token.token

          user_created.update!(current_token_version: 'changed_version')

          expect { described_class.from_refresh_token(token) }.to(raise_error do |error|
            expect(error).to be_a(Constants::Exceptions::TokenVersion)
            expect(error.message).to eq 'パスワードに変更がありました。再度ログインして下さい。'
          end)
        end
      end
    end

    context 'generate_access_token' do
      it 'JWTアクセストークンの発行' do
        user_created.generate_refresh_token
        access_token = user_created.generate_access_token
        expect(access_token.token).to be_present
      end

      it 'オプションで指定した値がアクセストークンに含まれる' do
        user_created.generate_refresh_token
        access_token_opsions = user_created.generate_access_token({ test: 'test' })
        token = access_token_opsions.token
        decoded_access_token = described_class.decode_access_token(token)
        expect(decoded_access_token['test']).to eq('test')
      end
    end

    context 'decode_access_token' do
      it '復号化されたアクセストークンが返る' do
        user_created.generate_refresh_token
        access_token = user_created.generate_access_token
        token = access_token.token
        decoded_access_token = described_class.decode_access_token(token)
        expect(decoded_access_token['sub']).to be_present
      end
    end

    context 'from_access_token' do
      it 'アクセストークンから持ち主のユーザを取り出す' do
        user_created.generate_refresh_token
        access_token = user_created.generate_access_token
        token = access_token.token
        user_searched = described_class.from_access_token(token)

        expect(user_searched.id).to eq(user_created.id)
      end

      context '異常系' do
        it 'token_versionがDBと異なる場合、例外処理発生' do
          user_created.generate_refresh_token
          access_token = user_created.generate_access_token
          token = access_token.token

          user_created.update!(current_token_version: 'changed_version')

          expect { described_class.from_access_token(token) }.to(raise_error do |error|
            expect(error).to be_a(Constants::Exceptions::TokenVersion)
            expect(error.message).to eq 'パスワードに変更がありました。再度ログインして下さい。'
          end)
        end
      end
    end

    context 'enforce_password_validation' do
      it 'パスワードのバリデーションを強制する' do
        user_searched = described_class.find(user_created.id)
        user_searched.enforce_password_validation

        expect { user_searched.update!(name: 'hiroki') }.to(raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message.split(',').first).to eq 'バリデーションに失敗しました: パスワードを入力してください'
        end)
      end
    end

    context 'logged_in_user' do
      it 'メール・パスワードが一致するユーザを返す' do
        login_user = described_class.logged_in_user(email: user_created.email, password: '1111111q')
        expect(login_user.email).to eq(user_created.email)
      end

      context '異常系' do
        it 'メールが一致しない' do
          expect { described_class.logged_in_user(email: 'no_exist_email', password: '1111111q') }
            .to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'パスワードが一致しない' do
          expect { described_class.logged_in_user(email: user_created.email, password: 'no_match_password') }
            .to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'メールがnil' do
          expect { described_class.logged_in_user(email: nil, password: '1111111q') }
            .to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'パスワードがnil' do
          expect { described_class.logged_in_user(email: user_created.email, password: nil) }
            .to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
