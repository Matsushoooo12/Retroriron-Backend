class ContactMailer < ApplicationMailer
    default from: 'retroriron@gmail.com'
    def send_mail(contact)
        @contact = contact
        mail(to: @contact.email, subject: 'お問い合わせありがとうございます。')
    end

    def send_admin_mail(contact)
        @contact = contact
        mail(to: 'retroriron@gmail.com', subject: 'お問い合わせが届きました。')
    end
end
