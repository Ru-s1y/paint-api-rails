module Api
  module V1
    class TagsController < ApplicationController
      include Pagenation
      before_action :set_tag, only: [:destroy_tag]
      before_action :authenticate_user, only: [:create_tag, :destroy_tag, :create_picture_tag, :destroy_picture_tag]

      # タグ一覧
      def index
        @tags = Tag.all.order(created_at: :desc).limit(30)
        render json: @tags
      end

      def all_tags
        @tags = Tag.all.order(name: :desc)
        render json: @tags
      end

      # タグ候補
      def index_tag
        @tags = Tag.where('name LIKE ?', "%#{params[:name]}%")
        if @tags
          render json: @tags
        else
          render json: {
            message: "Not found Tags"
          }
        end
      end

      # 検索 タグからピクチャーを探す
      def search_pictures
        @tag = Tag.find_by(name: params[:name])
        if @tag
          @pictures = @tag.pictures.where(publish: true).page(params[:page]).per(10)
          pagenation = resources_with_pagination(@pictures)
          render 'index.json.jbuilder'
        else
          render json: { message: "not found pictures" }
        end
      end

      # picture_idからタグを探す
      def search_tags
        @picture = Picture.find_by(id: params[:picture_id])
        @tags = @picture.tags
        if @tags
          render json: @tags
        else
          render json: { message: "not found tags" }
        end
      end

      # タグの関連づけ
      def create_picture_tag
        @picture_tag = PictureTag.create!(
          picture_id: params[:picture_id],
          tag_id: params[:tag_id]
        )
        if @picture_tag
          render json: @picture_tag
        else
          render json: {message: "error"}
        end
      end

      def destroy_picture_tag
        # @picture_tag = PictureTag.find_by(id: params[:id])
        @picture_tag = PictureTag.find_by(picture_id: params[:picture_id], tag_id: params[:tag_id])
        if @picture_tag.destroy
          render json: @picture_tag
        else
          render json: @picture_tag.errors
        end
      end

      # タグの新規作成
      def create_tag
        @tag = Tag.create!(tags_params)
        if @tag
          render json: @tag
        else
          render json: {
            message: "create failed"
          }
        end
      end

      # タグの削除
      def destroy_tag
        if @tag.destroy
          render json: @tag
        else
          reder json: @tag.errors
        end
      end

      private
        def set_tag
          @tag = find_by(id: tags_params[:id])
        end

        def tags_params
          params.require(:tag).permit(:name)
        end

        def picture_tag_params
          params.require(:picture_tag).permit(:id, :picture_id, :tag_id)
        end
    end
  end
end