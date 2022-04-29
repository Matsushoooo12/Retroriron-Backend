class Api::V1::TicketsController < ApplicationController
    protect_from_forgery
    def create
        ticket = Ticket.new(ticket_params)
        if ticket.save
            TicketMailer.send_mail(ticket).deliver_now
            TicketMailer.send_admin_mail(ticket).deliver_now
            render json: ticket
        else
            render json: ticket.errors, status: 422
        end
    end

    private
    def ticket_params
        params.require(:ticket).permit(:date, :title, :name_kana, :email, :number, :description)
    end
end