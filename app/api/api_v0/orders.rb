module ApiV0
  class Orders < Grape::API
    before { authenticate! }

    desc "Create new order"
    params do
      requires :program_id, type: Integer
    end
    post "/orders" do
      program_id = declared(params, include_missing: false).except(:access_key)['program_id']
      new_order = OrderCreator.new(current_user, program_id)
      order = new_order.send_order

      if order.present?
        present order, with: ApiV0::Entities::Order
      else
        raise StandardError, $!
      end
    end
  end
end
