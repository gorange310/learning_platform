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

    desc "Get all your orders"
    params do
      optional :type_id, type: Integer, desc: 'ProgramType filter.'
      optional :valid, type: Boolean, desc: 'Program valid filter.'
    end
    get "/orders" do
      type_id = declared(params, include_missing: false).except(:access_key)['type_id']
      valid = declared(params, include_missing: false).except(:access_key)['valid']

      orders = current_user.orders.includes(:user_program => :program)

      if type_id.present?
        orders = orders.joins(:user_program => :program).where('programs.program_type_id = ?', type_id)
      end

      if valid == true
        orders = orders.joins(:user_program).where('user_programs.expired_date >= ?', Date.today)
      end

      present orders, with: ApiV0::Entities::Order
    end
  end
end
