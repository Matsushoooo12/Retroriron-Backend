class Api::V1::NewsController < ApplicationController
    def index
        news = News.all.order(created_at: :desc)
        render json: news
    end
end