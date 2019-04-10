class StoredProductsController < ShopifyApp::AuthenticatedController
  before_action :set_stored_product, only: [:show, :edit, :update, :destroy]

  

  # GET /stored_products/1/edit
  def edit
    @product_images = @stored_product.product_images
  end


  # PATCH/PUT /stored_products/1
  # PATCH/PUT /stored_products/1.json
  def update
    respond_to do |format|
      if @stored_product.update(stored_product_params)
        format.html { redirect_to @stored_product, notice: 'Stored product was successfully updated.' }
        format.json { render :show, status: :ok, location: @stored_product }
      else
        format.html { render :edit }
        format.json { render json: @stored_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stored_products/1
  # DELETE /stored_products/1.json
  def destroy
    @stored_product.destroy
    respond_to do |format|
      format.html { redirect_to stored_products_url, notice: 'Stored product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stored_product
      @stored_product = StoredProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stored_product_params
      params.require(:stored_product).permit(:shopify_id, :shopify_title, :shopify_image_url, :shop_id)
    end
end
