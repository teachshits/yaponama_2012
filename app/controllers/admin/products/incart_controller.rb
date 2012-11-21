class Admin::Products::IncartController < Admin::ProductsController
  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

  end

  def index
  end

  def update
    @products.each do |product|
      product.status = 'incart'
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end
  end

end