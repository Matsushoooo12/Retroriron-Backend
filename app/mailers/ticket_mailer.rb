class TicketMailer < ApplicationMailer
    default from: 'retroriron@gmail.com'
    def send_mail(ticket)
        @ticket = ticket
        mail(to: @ticket.email, subject: 'レトロリロンのチケット予約が完了しました。')
    end

    def send_admin_mail(ticket)
        @ticket = ticket
        mail(to: 'retroriron@gmail.com', subject: 'チケット予約が届きました。')
    end
end
