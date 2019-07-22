class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    enum pay_type: {
        "Check"             =>0,
        "Credit card"       =>1,
        "Purchase order"    =>2
    }
    validates :name, :address, :email, presence: true
    validates :pay_type, inclusion: pay_types.keys

    def add_line_items_from_cart(cart)
        order_items = []
        cart.line_items.each do |item|
            item.cart_id = nil
            order_items << item
            # line_items << item
        end
        line_items + order_items
    end
end

# order = Order.new(id: 4)
# order.add_line_items_from_cart(cart)
# order.line_items     #  [XXX, OOO, AAA] = cart.line_items
