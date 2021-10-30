class Api::V1::ImagesController < ApplicationController
    def index
        images = Image.all.order(created_at: :desc)
        render json: images
    end
end