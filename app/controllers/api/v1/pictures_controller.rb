module Api
  module V1
    class PicturesController < ApplicationController
      include Pagenation
      before_action :authenticate_user, only: [:create, :update, :destroy]
      before_action :set_picture, only: [:update, :destroy]

      def index
        @pictures = Picture.where(publish: true).order(created_at: :desc).page(params[:page]).per(12)
        pagenation = resources_with_pagination(@pictures)
        render 'index.json.jbuilder'
      end

      def create
        image = picture_params[:image]
        uri = URI.parse(image)
        if uri.scheme == "data" then
          data = decode(uri)
          extension = extension(uri)
          imageURL = put_s3 data, extension
          # if Rails.env.production?
          # else
          #   # development or test upload file path
          #   # data, extension
          # end
        end
        
        @picture = Picture.new(
          name: picture_params[:name],
          description: picture_params[:description],
          image: imageURL,
          publish: picture_params[:publish],
          user_id: current_user.id
        )
        if @picture.save
          render json: @picture
        else
          render json: @picture.errors
        end
      end

      def update
        if @picture.update(picture_params)
          if params[:tag_id]
            @tag = Tag.find(params[:tag_id])
            if !@tag
              @tag = Tag.create!(name: params[:tag_name])
            end
            @picture_tag = PictureTag.create!(
              picture_id: params[:picture_id],
              tag_id: params[:tag_id]
            )
          end
          render json: @picture
        else
          render json: @picture.errors
        end
      end

      def destroy
        @picture.destroy
        render json: @picture
      end

      private
        def picture_params
          params.require(:picture).permit(:id, :name, :description, :image, :publish)
        end

        def tag_params
          params.require(:tag).permit(:name)
        end

        def set_picture
          @picture = Picture.find_by(id: picture_params[:id])
        end

        # 以下アップロード関連

        # Base64デコード
        def decode(uri)
          opaque = uri.opaque
          data = opaque[opaque.index(",") + 1, opaque.size]
          Base64.decode64(data)
        end

        # 拡張子の取得
        def extension(uri)
          opaque = uri.opaque
          mime_type = opaque[0, opaque.index(";")]
          case mime_type
          when "image/png" then
            ".png"
          when "image/jpeg" then
            ".jpg"
          else
            raise "Unsupport Content-Type"
          end
        end

        # AWS S3 Upload
        def put_s3(data, extension)
          file_name = Digest::SHA1.hexdigest(data) + extension
          s3 = Aws::S3::Resource.new(
            :region => ENV['AWS_S3_REGION'],
            :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
            :secret_access_key => ENV['AWS_ACCESS_SECRET_KEY']
          )
          bucket = s3.bucket(ENV['AWS_S3_BUCKET'])
          obj = bucket.object("uploader/#{current_user.id}/#{file_name}")
          obj.put(acl: "public-read", body: data)
          obj.public_url
        end
      end
  end
end