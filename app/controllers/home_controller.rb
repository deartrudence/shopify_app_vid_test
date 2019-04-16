class HomeController < ShopifyApp::AuthenticatedController

  def index
    # if the script has not yet been loaded in the head do so
    if !ShopifyAPI::ScriptTag.where(src: "#{request.base_url}/test.js").present?	
      puts "INSIDE THE IFFFF"
  		ShopifyAPI::ScriptTag.create(:event => "onload", :src => "#{request.base_url}/test.js")
  	end

  	@scripts = ShopifyAPI::ScriptTag.all
    puts "🐟🐟🐟#{@scripts}"
    @scripts.each do |script|
  		puts "#{script.id} #{script.src} NEW SCRIPT"
    end
    

    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })

    @products.each do |product|
      puts "PRODUCT"
      puts product
      puts product.handle
      StoredProduct.where(shopify_id: product.id.to_s).first_or_create do |stored_product|
        stored_product.shopify_id = product.id
        stored_product.shopify_title = product.title 
        stored_product.shopify_handle = product.handle
        puts 'shopify store product'
        puts stored_product
        stored_product.shopify_image_url = product.image.src 
        stored_product.shop_id = @shop.id
        stored_product.save

        product.images.each do |image|
          ProductImage.where(shopify_id: image.id.to_s).first_or_create do |product_image|
            product_image.image_url = image.src
            product_image.stored_product_id = stored_product.id
            product_image.shopify_id = image.id.to_s
          end
        end
      end
    end
    @stored_products = StoredProduct.all
  end
end
