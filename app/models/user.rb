class User < ActiveRecord::Base

  attr_accessible :notes, :notes_invisible
  attr_accessible :created_at, :updated_at

  after_initialize  do |user|
    unless user.account
      user.account = Account.new
    end
  end

  attr_accessible :cars_attributes
  has_many :cars, :dependent => :destroy
  accepts_nested_attributes_for :cars, :allow_destroy => true 

  attr_accessible :requests_attributes
  has_many :requests, :dependent => :destroy
  accepts_nested_attributes_for :requests, :allow_destroy => true 

  attr_accessible :root_requests_without_car_attributes
  has_many :root_requests_without_car, :dependent => :destroy,
    :conditions => ["request_id IS NULL AND car_id IS NULL"], :class_name => "Request"
  accepts_nested_attributes_for :root_requests_without_car, :allow_destroy => true

  has_many :products, :dependent => :destroy
  has_many :products_incart, :dependent => :destroy,
    :conditions => {:status => :incart}, :class_name => "Product"

  attr_accessible :products_incart_attributes
  accepts_nested_attributes_for :products_incart, :allow_destroy => true

  include PingCallback

  attr_accessible :name, :phones_attributes, :email_addresses_attributes, :postal_addresses_attributes, :names_attributes, :time_zone_id, :human_confirmation_datetime, :orders_attributes, :money_available, :money_locked, :discount, :prepayment_percent
  has_many :email_addresses, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :postal_addresses, :dependent => :destroy
  has_many :names, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  accepts_nested_attributes_for :phones, :postal_addresses, :email_addresses, :names, :orders, :allow_destroy => true
  belongs_to :time_zone, :validate => true
  has_one :ping, :dependent => :destroy
  has_many :documents, :as => :documentable, :class_name => "Transaction"

  validates :prepayment_percent, :numericality => true
  validates :discount, :numericality => true

  attr_accessible :order_rule
  validates :order_rule, :inclusion => { :in => Rails.configuration.user_order_rule.keys }

  # Financial
  attr_accessible :account_attributes
  has_one :account, :as => :accountable
  accepts_nested_attributes_for :account

  def to_label
    "#{id} - #{names.collect{|name| name.name}.join(', ')}"
  end

  def check_orders
    raise '1'
    # TODO CHECK
    
    if order_rule.to_sym == :none
      return
    elsif order_rule.to_sym == :all 
      inorder_orders = orders.where(:status => :inorder)
      unless (account.debit + inorder_orders.inject(0){|summ, order| summ += order.order_cost}) * prepayment_percent / 100.00 <= account.credit
        return
      end

      inorder_orders.each do |order|
        if (account.debit + order.order_cost) * prepayment_percent / 100.00 <= account.credit
          order.status = :ordered
          order.products.each do |product|
            product.update_attributes(:status => :ordered)
          end
          account.debit += order.order_cost
          order.save
          account.save
        end
      end

    end

  end
end
