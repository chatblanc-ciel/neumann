require 'jwt'

module Token
  class RefreshToken
    include UserAuth::TokenConcern

    attr_reader :payload, :token

    def initialize(user_id)
      @payload = claims(user_id)
      @token = JWT.encode(@payload, secret_key, algorithm, header_fields)
      store_token_version(user_id, @payload[:version])
    end

    class << self
      def decode(token)
        JWT.decode(token.to_s, UserAuthConfig.token_secret_signature_key, true).first
      end
    end

    private

    # リフレッシュトークンの有効期限
    def token_lifetime
      UserAuthConfig.refresh_token_lifetime
    end

    # 有効期限をUnixtimeで返す(必須)
    def token_expiration
      token_lifetime.from_now.to_i
    end

    def store_token_version(user_id, token_version)
      User.find(user_id).update_token_version(token_version)
    end

    # エンコード時のデフォルトクレーム
    def claims(user_id)
      {
        user_claim => encrypt_for(user_id),
        exp: token_expiration,
        version: new_token_version
      }
    end
  end
end