# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview
    def ticket
        ticket = Ticket.new(title: 'こんにちは', date: '2022-04-29',name_kana: 'マツモトショウゴ', email: 'matsush.oooo12@icloud.com')
        TicketMailer.send_mail(ticket)
    end
end
