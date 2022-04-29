# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    def contact
        contact = Contact.new(name: 'マツモトショウゴ', email: 'matsush.oooo12@icloud.com', phone: '08082422970', content: 'こんにちはこんにちはこんにちはこんにちは')
        ContactMailer.send_mail(contact)
    end
end
