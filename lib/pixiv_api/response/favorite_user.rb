module PixivApi
  class Response
    class FavoriteUser < Identity
      attr_reader :id, :user_id, :publicity
      define_attribute_method :target_user, Response::User
    end
  end
end
