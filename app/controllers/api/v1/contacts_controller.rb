class Api::V1::ContactsController < ApplicationController
    protect_from_forgery
    def create
        contact = Contact.new(contact_params)
        if contact.save
            ContactMailer.send_mail(contact).deliver_now
            ContactMailer.send_admin_mail(contact).deliver_now
            render json: contact
        else
            render json: contact.errors, status: 422
        end
    end

    private
    def contact_params
        params.require(:contact).permit(:name, :email, :phone, :content)
    end
end