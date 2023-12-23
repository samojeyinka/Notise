module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        @posts = Post.all
        render json: @posts, each_serializer:  Api::V1::PostSerializer
      end

      def show
        render json: @post, serializer:  Api::V1::PostSerializer
      end

      def create
        @post = Post.new(post_params)
        handle_image_attachment
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          handle_image_attachment
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :content, :image)
      end

      def handle_image_attachment
        return unless params[:post][:image]
      
        @post.image.attach(params[:post][:image])
      end

    end
  end
end

