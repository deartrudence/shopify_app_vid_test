class StoredProductsController < ShopifyApp::AuthenticatedController
  before_action :set_stored_product, only: [:show, :edit, :update, :destroy]

  # def index
  #   @stored_product = StoredProduct.all
  # end

  # GET /stored_products/1/edit
  def edit
    if @stored_product.shop_id.to_i == @shop.id
      @product_images = @stored_product.product_images
      @blocks = @stored_product.blocks
    else 
      redirect_to root_path
    end
  end


  # PATCH/PUT /stored_products/1
  # PATCH/PUT /stored_products/1.json
  def update
    #delete all the current blocks
    @stored_product.blocks.destroy_all

    #rebuild all the new blocks
    params[:blocks].each do |block|
      Block.where(block_id: block['block_id']).first_or_create do |this_block|
        this_block.image_url = block['image_url']
        this_block.block_type = block['block_type']
        this_block.block_id = block['block_id']
        this_block.block_text = block['block_text']
        this_block.stored_product_id = @stored_product.id
      end
    end
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
      params.require(:stored_product).permit(:shopify_id, :shopify_title, :shopify_image_url, :lookbook_html, :shop_id)
    end
end
