describe ApiV0::Orders do
  let(:user) { create(:user) }
  let(:access_token) { create(:api_access_token, user: user) }

  context 'POST /api/v0/orders' do
    subject(:post_request) { post '/api/v0/orders', params: { access_key: access_token.key, program_id: program.id } }
    let(:program) { create(:program, status: status) }

    context 'a active program' do
      let(:status) { 'active' }
      it 'should return 200 and new_order' do
        post_request
        result = JSON.parse(response.body)

        expect(response.status).to eq(201)
        expect(result['program']['name']).to eq(program.name)
        expect(result['status']).to eq('paid')
        expect(result['amount']).to eq(program.price)
        expect(result['currency']['name']).to eq(program.currency.name)
        expect(result['date'].to_date).to eq(Date.today)
      end
    end

    context 'a inactive program' do
      let(:status) { 'inactive' }
      it 'should raise error' do
        expect { post_request }.to raise_error(StandardError)
      end
    end
  end

  context 'GET /api/v0/orders' do
    context 'without params' do
      it 'should return 200 and orders' do
        create_orders(user)
        get '/api/v0/orders', params: { access_key: access_token.key }

        result = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(result.size).to eq(user.orders.size)
      end
    end

    context 'with params type_id' do
      it 'should return 200 and orders of the type of programs' do
        create_orders(user)
        get '/api/v0/orders', params: { access_key: access_token.key, type_id: ProgramType.first.id }

        result = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(result.size).to eq(3)
      end
    end

    context 'with params valid true' do
      it 'should return 200 and orders of the valid programs' do
        travel_to Time.zone.local(2022, 2, 12)
        create_orders(user)

        travel_to Time.zone.local(2022, 3, 01)
        get '/api/v0/orders', params: { access_key: access_token.key, valid: true }

        result = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(result.size).to eq(4)
      end
    end

    context 'with params type_id and valid true' do
      it 'should return 200 and orders of the type of valid programs' do
        travel_to Time.zone.local(2022, 2, 12)
        create_orders(user)

        travel_to Time.zone.local(2022, 2, 20)
        get '/api/v0/orders', params: { access_key: access_token.key, type_id: ProgramType.first.id, valid: true }

        result = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(result.size).to eq(2)
      end
    end
  end

  private

  def create_orders(user)
    program_types = create_list(:program_type, 3)
    program_types.each_with_index do |type, index|
      create(:program, status: 'active', program_type_id: type.id, validity_period: ((index + 1) * 10))
      create(:program, status: 'active', program_type_id: type.id, validity_period: ((index + 1) * 8))
      create(:program, status: 'active', program_type_id: type.id, validity_period: ((index + 1) * 6))
    end

    program_ids = Program.ids
    program_ids.each do |program_id|
      OrderCreator.new(user, program_id).send_order
    end
  end
end
