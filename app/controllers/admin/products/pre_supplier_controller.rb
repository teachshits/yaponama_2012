# encoding: utf-8

class Admin::Products::PreSupplierController < Admin::ProductsController

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.scoped, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['ordered']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create
    @products.each do |product|
      product.status = 'pre_supplier'
      product.status_will_change!
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end
    redirect_to_relative_path('pre_supplier')
  end

end
