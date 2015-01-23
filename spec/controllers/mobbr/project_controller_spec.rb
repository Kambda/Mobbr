require 'spec_helper'

describe Mobbr::ProjectController do

  describe "GET 'issues'" do
    it "returns http success" do
      get 'issues'
      response.should be_success
    end
  end

end
