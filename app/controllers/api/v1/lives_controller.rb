class Api::V1::LivesController < ApplicationController
    def index
        lives = Live.all.order(created_at: :desc)
        render json: lives
    end
end