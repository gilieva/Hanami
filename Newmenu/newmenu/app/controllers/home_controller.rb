class HomeController < ApplicationController
  def index

     check_data = params[:start_date]
  if(!check_data.nil?)
    @date_a = check_data
  else
    @date_a = Time.now.strftime("%Y-%m-%d")
  end
  	@meetings = Meeting.all
  	if user_signed_in?
  	else
  		redirect_to new_user_session_path
  	end
    @date_a = params[:start_date]
    @user = current_user.id

     @products_supi = Product.where(category: "supi")
     @products_osnovni = Product.where(category: "osnovni")
     @products_sandvichi = Product.where(category: "sandvichi")
     @products_deserti = Product.where(category: "deserti")
     @products_napitki = Product.where(category: "napitki")
     


     id_array = []
     @date = 0

     @products = Product.all
     id_array = []


     @for_home = 0
     @items_array =  []
     @items_array_product =  []
     @counter=0
    @counter_del=0
     @sum =0
     
      @orders = Order.where(user_id: @user,date:@date_a ).all
      @orders.each do |order_id|
          id_array = id_array.push(order_id.id)
      end
  
     @order_items =  OrdersItem.where(order_id:  id_array).all
  
    @order_items.each do |order_items_id|
      @items_array = @items_array.push(order_items_id.id)
    end
      @order_items.each do |order_items_product|
       @items_array_product = @items_array_product.push(order_items_product.product_id)

     end
     
     
        @current_products = Product.where(id: @items_array_product)
    
     @order_items.each do |order_items_total_sum|
      @sum = @sum +order_items_total_sum.total_price
      end

  end


  def home
  	@meetings = Meeting.all
  end
  def item_params
  params.require(:selected_product_id).permit(:value)
  end


  def create
    total_price = 0
    if(params[:for_home]) 
      for_home =(params[:for_home].gsub(/[^0-9]/, '')).to_i
    end
      if(for_home == 1)
        for_home = 1
    
      else
        for_home = 0
      end



      date = params[:date]



     quantity = params[:quantity].to_i
       description =params[:description]
      create_this_user_order = current_user.id 
      product_price = Product.where(id: @items_array_product).all
 
     
    
       create_this_product_id = (params[:product_id].gsub(/[^0-9]/, '')).to_i
       product_price = Product.where(id: create_this_product_id).first
       
         total_price = product_price.price* quantity
      

      

      object_order = Order.new(:user_id => create_this_user_order,:date => date)
      object_order.save
     select_last_order_id = Order.last.id
     object_orders_item = OrdersItem.new(:product_id => create_this_product_id , :order_id =>  select_last_order_id ,:quantity => quantity,:description => description ,:date => date,:for_home =>for_home,:total_price => total_price,:date => date )
     object_orders_item.save
     redirect_to '/'
  end
  def update
    current_product_price = params[:product_price].to_f
    order_item_id_update = params[:order_item_id_update]
    get_less = params[:less].to_i
    get_add = params[:add].to_i
    if(get_add >= 1)
        update_order_item_quantity = OrdersItem.find_by(id: order_item_id_update)
        add_to_quantity = get_add + 1
        update_total_price = current_product_price*add_to_quantity
        update_order_item_quantity.update(quantity: add_to_quantity,total_price: update_total_price)
      else
        if(get_less > 1)
        update_order_item_quantity = OrdersItem.find_by(id: order_item_id_update)
        less_to_quantity = get_less - 1
         update_total_price = current_product_price*less_to_quantity

        update_order_item_quantity.update(quantity: less_to_quantity,total_price: update_total_price)
      end
      end


       redirect_to '/'
  end
  def new

  end
  def destroy
    this_user = current_user.id
    

    delete_this_id = params[:id]
    delete_current_product_order_items_id  = params[:current_product_order_items_id]
  
     OrdersItem.where(product_id: delete_this_id,id: delete_current_product_order_items_id).destroy_all
    Order.where(id: delete_current_product_order_items_id,user_id: this_user).destroy_all
   
    
    
     redirect_to '/'
  end
  def show
  end

  def help
  end

  def about
  end
end


