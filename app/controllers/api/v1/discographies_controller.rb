class Api::V1::DiscographiesController < ApplicationController
    def index
        discographies = Discography.all.order(created_at: :desc)
        render json: discographies
    end
end