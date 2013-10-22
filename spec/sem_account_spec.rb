require 'spec_helper'

describe Sogou::SEM::AccountService do
  subject{Sogou::SEM::AccountService.new($auth)}
  let(:options){options = {}}
  describe "#getAccountInfo" do
    it "getAccountInfo" do
      response = subject.getAccountInfo(options)
      response.status.should == 0
      response.desc.should == 'success'
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
    end
  end
end