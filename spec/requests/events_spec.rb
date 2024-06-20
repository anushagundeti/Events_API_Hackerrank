require 'rails_helper'

describe 'Events', type: :request do
  describe 'POST /events' do
    let(:event_type) { 'PushEvent' }

    let(:event_params) do
      {
        event_type: event_type,
        public: true,
        repo_id: 1,
        actor_id: 2
      }
    end

    before do
      post '/events', params: event_params
    end

    context 'when incoming parameters are valid' do
      it 'returns status code 201' do
        expect(response.status).to eq(201)
      end

      it 'adds an event to the database' do
        get '/events'
        fail('Cannot access GET /events') unless response.status == 200

        expected = [
          {
            id: 1,
            event_type: 'PushEvent',
            public: true,
            repo_id: 1,
            actor_id: 2
          }.stringify_keys
        ]

        expect(JSON.parse(response.body)).to eq(expected)
      end

      it 'returns JSON of a created event' do
        expected = {
          id: 1,
          event_type: 'PushEvent',
          public: true,
          repo_id: 1,
          actor_id: 2
        }.stringify_keys

        expect(JSON.parse(response.body)).to eq(expected)
      end
    end

    context 'when event_type is invalid' do
      let(:event_type) { 'invalid' }

      it 'returns status code 400' do
        expect(response.status).to eq(400)
      end

      it 'does not add the event to the database' do
        get '/events'
        fail('Cannot access GET /events') unless response.status == 200

        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET /events/:id' do
    context 'when an event by given ID exists' do
      let(:event_params) do
        {
          event_type: 'ReleaseEvent',
          public: true,
          repo_id: 3,
          actor_id: 4
        }
      end

      let(:event) do
        post '/events', params: event_params
        fail('Cannot create an event') unless response.status == 201
        JSON.parse(response.body)
      end

      before do
        get "/events/#{event['id']}"
      end

      it 'returns 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'returns JSON of a corresponding event' do
        expected = {
          id: event['id'],
          event_type: 'ReleaseEvent',
          public: true,
          repo_id: 3,
          actor_id: 4
        }.stringify_keys

        expect(JSON.parse(response.body)).to eq(expected)
      end
    end

    context 'when an event by given ID does not exist' do
      before do
        get '/events/999'
      end

      it 'returns 404 status code' do
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'GET /events' do
    it 'returns status 200' do
      get '/events'
      expect(response.status).to eq(200)
    end

    context 'when there are events in the system' do
      let(:event_params) do
        [
          {
            event_type: 'WatchEvent',
            public: false,
            repo_id: 3,
            actor_id: 4
          },
          {
            event_type: 'PushEvent',
            public: true,
            repo_id: 3,
            actor_id: 5
          } 
        ]
      end

      before do
        event_params.each do |params|
          post '/events', params: params
          fail('Cannot create an event') unless response.status == 201
        end
      end

      it 'returns events collection ordered by ID' do
        get '/events'

        expected = event_params.each.with_index(1) do |params, index|
          params['id'] = index
        end.map(&:stringify_keys)

        expect(JSON.parse(response.body)).to eq(expected)
      end
    end

    context 'when there are no events in the system' do
      it 'returns empty array JSON' do
        get '/events'
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET /repos/:repo_id/events' do
    let(:repo_id) { 10 }

    it 'returns status 200' do
      get "/repos/#{repo_id}/events"
      expect(response.status).to eq(200)
    end

    context 'when there are events in the system' do
      let(:event_params) do
        [
          {
            event_type: 'WatchEvent',
            public: false,
            repo_id: repo_id,
            actor_id: 4
          },
          {
            event_type: 'PushEvent',
            public: true,
            repo_id: repo_id,
            actor_id: 5
          },
          {
            event_type: 'PushEvent',
            public: true,
            repo_id: 999,
            actor_id: 10
          } 
        ]
      end

      before do
        event_params.each do |params|
          post '/events', params: params
          fail('Cannot create an event') unless response.status == 201
        end
      end

      it 'returns events collection of a given repo ordered by ID' do
        get "/repos/#{repo_id}/events"

        expected_events = [event_params[0], event_params[1]]
        expected = expected_events.each.with_index(1) do |params, index|
          params['id'] = index
        end.map(&:stringify_keys)

        expect(JSON.parse(response.body)).to eq(expected)
      end
    end

    context 'when there are no events in the system' do
      it 'returns empty array JSON' do
        get "/repos/#{repo_id}/events"
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end
end
