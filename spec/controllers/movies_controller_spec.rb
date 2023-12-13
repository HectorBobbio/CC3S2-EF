require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe MoviesController do
  describe 'seatching TMDb' do

    # Suposicion #1
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end
    it 'calls the model method that performs TMDb search' do
      expect(Movie).to receive(:find_in_tmdb).with('hardware').
      and_return(@fake_results)
      get :search_tmdb, {:search_terms => 'hardware'}
    end

    describe 'after valid search' do
      # Suposicion #2 anidada
      before :each do
        allow(Movie).to receive(:find_in_tmdb).and_return(@fake_results)
        get :search_tmdb, {:search_terms => "hardware"}
      end

      it 'selects the Search Results template for rendering' do
        expect(response).to render_template('search_tmdb')
      end
      it 'makes the TMDb search results available to that template' do
        expect(assigns(:movies)).to eq(@fake_results)
      end
    end
  end
end
