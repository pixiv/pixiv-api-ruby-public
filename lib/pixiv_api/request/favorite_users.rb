module PixivApi
  module Request
    module FavoriteUsers
      def favorite_users(*args)
        objects_from_response(Response::FavoriteUser, :get, '/v1/me/favorite-users.json', args.extract_options!)
      end
    end
  end
end
