describe ApiV0::Orders do
  let(:user) { create(:user) }
  let(:program) { create(:program, status: status) }
  let(:access_token) { create(:api_access_token, user: user) }

  context 'POST /api/v0/orders' do
    subject(:post_request) { post '/api/v0/orders', params: { access_key: access_token.key, program_id: program.id } }

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
end
