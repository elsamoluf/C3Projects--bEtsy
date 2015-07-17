require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET new" do

    before :each do
      @product = Product.new(id: 1, name: "some name", price: 1, user_id: 1)
      @item = OrderItem.new(quantity: 2, product_id: 1)
      @product.save
    end

    it "saves a new blank instance of item in a variable" do
      get :new, :product_id => @product.id
      expect(@item.quantity).to eq 2
    end

    it "renders a new page" do
      get :new, :product_id => @product.id
      expect(subject).to render_template(:new)
    end
  end

  describe "POST create" do
    let (:params) do {order_item: {id: 1, name: "a name", quantity: 1, product_id: 1 }}
    end

    it "creates a new OrderItem" do
      post :create, params

      expect(OrderItem.count).to eq 1
    end

    it "redirects to the cart index page" do
        post :create, params

        expect(subject).to redirect_to(cart_path)
      end

  end
end
