require "rails_helper"

RSpec.describe JukeboxController, :type => :controller do

  before(:each) { get :reset }

  it "responds successfully with an HTTP 200 status code when voting" do
    post :vote
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  it "could vode and take that track" do
    video_id = 11
    post :vote, {:video_id => video_id}

    get :take

    json_reponse = JSON.parse(response.body)

    expect(json_reponse["video_id"]).to eq(video_id.to_s)
    expect(json_reponse["votes"]).to eq(1)
    expect(json_reponse["proposed_date"]).to be > (DateTime.now - 1.hour)
  end

end