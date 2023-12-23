module Api
  module V1
    class PostSerializer < ActiveModel::Serializer
      attributes :id, :title, :content, :image_url
      
      def image_url
        Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
      end
    end
  end
end

