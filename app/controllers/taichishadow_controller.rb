class TaichishadowController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        order = Order.select(:name, :id, :email).where.not(:id => '楊宏').order(:id => 'desc').limit(100)
        line_item = LineItem.all()

        result = []
        line_item.each do |temp|
            box = order.select do |item| 
                result.push(item) if item.id == temp.order_id
            end
        end
        render json: result
    end

    def index2
        condition = { 
            id: params[:id], 
            name: params[:name] 
        }
        orderby = {
            id: 'desc'
        }
        result = Order.where(condition).order(orderby)
        render json: result
    end

    def create
        Product.create(product_params)
    end

    def read
        product = Product.all
        render json: product
    end

    def read2
        arrayResult = []
        products = Product.getProductLineitem
        products.each do |product|
            if(product.line_items.length>0)
                result = {
                    title: product.title,
                    price: product.price,
                    line_item: product.line_items
                }
                arrayResult << result
            end
        end
        render json: arrayResult

        #Product.all.each do |p|
        #    box << p.line_items
        #end 
    end

    def delete
        Product.destroy(params[:id])
    end
    
    def detail
        product = Product.find(params[:id])
        render json: product
    end

    def update
        Product.update(product_params)
    end

    def purchase
        product = Product.find_by(product_params)
        line_item = LineItem.where(product_id: params[:id]).first
        if line_item
            line_item.quantity += 1
            line_item.save
        else
            cart = Cart.create
            line_item = LineItem.new(product_id: product.id, cart_id: cart.id, order_id: 0)
            line_item.save!
        end
    end
    #{ 'product': 'abc', 'price': 500 }
    #params[:product] = 'abc'
    #params[:price] = 500

    #Product.create(params)

    #product: 'abc', price: 500

    def product_params
        params.permit(:id, :title, :description, :image_url, :price)
    end
end
