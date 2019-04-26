# frozen_string_literal: true

module ShopifyApp
  # Performs login after OAuth completes
  class CallbackController < ActionController::Base
    include ShopifyApp::LoginProtection

    def callback
      if auth_hash
        login_shop
        install_webhooks
        install_scripttags
        perform_after_authenticate_job

        check_for_recurring_charge

        # redirect_to return_addressc <-- take this out
      else
        flash[:error] = I18n.t('could_not_log_in')
        redirect_to login_url
      end
    end

    def check_for_recurring_charge
      # Create Recurring Charge
      sess = ShopifyAPI::Session.new(shop_name, token)
      ShopifyAPI::Base.activate_session(sess)
      if ShopifyAPI::RecurringApplicationCharge.current
        puts 'NO CHARGE 👌'
        redirect_to return_address  #<-- move to here
      else
        puts 'create a charge 🙆'
        create_recurring_application_charge
      end
    end

    def create_recurring_application_charge
      unless ShopifyAPI::RecurringApplicationCharge.current
        recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
            name: "Artisan Application",
            price: 14.99,
            return_url: "#{ENV["app_url"]}/activatecharge",
            test: true,
            trial_days: 15)
        if recurring_application_charge.save
          redirect_to recurring_application_charge.confirmation_url
        end
      end
    end


    private

    def login_shop
      reset_session_options
      set_shopify_session
    end

    def auth_hash
      request.env['omniauth.auth']
    end

    def shop_name
      auth_hash.uid
    end

    def associated_user
      return unless auth_hash['extra'].present?

      auth_hash['extra']['associated_user']
    end

    def token
      auth_hash['credentials']['token']
    end

    def reset_session_options
      request.session_options[:renew] = true
      session.delete(:_csrf_token)
    end

    def set_shopify_session
      session_store = ShopifyAPI::Session.new(shop_name, token)

      session[:shopify] = ShopifyApp::SessionRepository.store(session_store)
      session[:shopify_domain] = shop_name
      session[:shopify_user] = associated_user
    end

    def install_webhooks
      return unless ShopifyApp.configuration.has_webhooks?

      WebhooksManager.queue(
        shop_name,
        token,
        ShopifyApp.configuration.webhooks
      )
    end

    def install_scripttags
      return unless ShopifyApp.configuration.has_scripttags?

      ScripttagsManager.queue(
        shop_name,
        token,
        ShopifyApp.configuration.scripttags
      )
    end

    def perform_after_authenticate_job
      config = ShopifyApp.configuration.after_authenticate_job

      return unless config && config[:job].present?

      if config[:inline] == true
        config[:job].perform_now(shop_domain: session[:shopify_domain])
      else
        config[:job].perform_later(shop_domain: session[:shopify_domain])
      end
    end
  end
end
