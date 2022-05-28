class TicketMailer < ApplicationMailer
    default from: ENV['EMAIL_ADDRESS']
    def send_mail(ticket)
        @ticket = ticket
        mail(to: @ticket.email, subject: 'レトロリロンのチケット予約確認メール')
    end

    def send_admin_mail(ticket)
        @ticket = ticket
        mail(to: ENV['EMAIL_ADDRESS'], subject: 'レトロリロンのチケット予約確認メール')
    end
end
