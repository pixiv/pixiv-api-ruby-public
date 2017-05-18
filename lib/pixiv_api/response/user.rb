module PixivApi
  class Response
    class User < Identity
      attr_reader :id, :account, :name, :is_following, :is_follower,
        :is_friend, :is_premium, :stats, :profile, :email

      define_blob_method :profile_image_urls

      def avatar_url
        blob_profile_image_urls['px_50x50']
      end
      memoize(:avatar_url)
    end
  end
end
