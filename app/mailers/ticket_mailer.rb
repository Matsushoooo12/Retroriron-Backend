class TicketMailer < ApplicationMailer
    default from: 'matsush.oooo12@gmail.com'
    def send_mail(ticket)
        @ticket = ticket
        mail(to: @ticket.email, subject: 'レトロリロンのチケット予約が完了しました。')
    end
end
