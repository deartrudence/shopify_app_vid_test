class ChargesController < ShopifyApp::AuthenticatedController
  include ApplicationHelper
  # set shop to the current Shop using the token stored in the shop_session from the ShopifyApp Authenticated Controller
  before_action :set_shop
  def activate_charge
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    puts "✨✨✨✨ #{request.params['charge_id']}"
    recurring_application_charge.status == "accepted" ? recurring_application_charge.activate : redirect_to(root_path)
    redirect_to(root_path)
  end
end
