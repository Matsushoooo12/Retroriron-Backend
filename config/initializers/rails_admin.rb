RailsAdmin.config do |config|
  require "nested_form/engine"
  require "nested_form/builder_mixin"

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == ENV['USER_NAME'] && password == ENV['USER_PASSWORD']
    end
  end

  module RailsAdmin 
    module Config 
      module Fields 
        module Types 
          class Datetime < RailsAdmin::Config::Fields::Base
            register_instance_option :date_format do 
              :default
            end
          end
          class Date < RailsAdmin::Config::Fields::Types::Datetime 
            register_instance_option :date_format do 
              :default
            end
          end
        end 
      end 
    end
  end
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
