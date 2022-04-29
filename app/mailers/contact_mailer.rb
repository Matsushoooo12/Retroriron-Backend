class ContactMailer < ApplicationMailer
    default from: 'matsush.oooo12@gmail.com'
    def send_mail(contact)
        @contact = contact
        mail(to: @contact.email, subject: 'お問い合わせありがとうございます。')
    end

    def send_admin_mail(contact)
        @contact = contact
        mail(to: 'gokusho.matsusho@gmail.com', subject: 'お問い合わせが届きました。')
    end
end
