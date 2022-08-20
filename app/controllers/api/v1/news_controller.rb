class Api::V1::NewsController < ApplicationController
    def index
        news = News.all.order(date: :desc)
        render json: news
    end
end