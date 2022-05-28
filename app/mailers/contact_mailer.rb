class ContactMailer < ApplicationMailer
    default from: ENV['EMAIL_ADDRESS']
    def send_mail(contact)
        @contact = contact
        mail(to: @contact.email, subject: 'レトロリロンへのお問い合わせ確認メール')
    end

    def send_admin_mail(contact)
        @contact = contact
        mail(to: ENV['EMAIL_ADDRESS'], subject: 'レトロリロンへのお問い合わせ確認メール')
    end
end
