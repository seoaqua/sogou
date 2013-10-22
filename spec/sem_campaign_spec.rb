require 'spec_helper'
describe Sogou::SEM::CampaignService do
  subject{Sogou::SEM::CampaignService.new($auth)}

  describe '#addCampaign #updateCampaign #getCpcPlanByCpcPlanId #deleteCampaign' do
    pending
    it "should not raise errors when add, update, and delete a temp campaign" do
      # ap subject.example('deleteCpcPlan')
      # pending
      #addCampaign
      campaign_type_add = {
        :cpcPlanName=> 'campaignName18',
        :budget => '100',
        :negativeWords => ['7day'],
        :exactNegativeWords => ['7daysin']
      }
      options = {:cpcPlanTypes => [campaign_type_add]}
      response = subject.addCpcPlan(options)
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should == 1
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      #parse and verify campaign_id
      campaign_id = response.body[:cpc_plan_types][:cpc_plan_id]
      campaign_id.to_i.to_s.should == campaign_id

      #updateCpcPlan
      campaign_type_update =
      {
        :cpcPlanId => campaign_id,
        :cpcPlanName => 'campaignName19',
        :budget => '101',
        :negativeWords => ['8day'],
        :exactNegativeWords => ['8daysin']
      }
      sleep 2
      options = {:cpcPlanTypes => [campaign_type_update]}
      response = subject.updateCpcPlan(options)
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should == 1
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      #check the result of updateCpcPlan by getCpcPlanByCpcPlanId
      response = subject.getCpcPlanByCpcPlanId({:cpcPlanIds => [campaign_id]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should == 1
      response.rquota.should > 0
      sleep 2
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      # ap response.body
      response.body[:cpc_plan_types][:cpc_plan_name].should == 'campaignName19'
      response.body[:cpc_plan_types][:budget].should == '101.0'
      response.body[:cpc_plan_types][:negative_words].should == '8day'
      response.body[:cpc_plan_types][:exact_negative_words].should == "8daysin"

      #deleteCpcPlan
      response = subject.deleteCpcPlan({:cpcPlanIds=>[campaign_id]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should == 1
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
    end
  end

  # describe '#getCpcPlanByCpcPlanId' do
  #   it "getCpcPlanByCpcPlanId" do
  #     # puts '==============='
  #     # puts subject.example('getAllCampaign')
  #     # {:GetCampaignByCampaignIdRequest=>{:campaignIds=>["long"]}}
  #     # puts '==============='
  #     response = subject.getCpcPlanByCpcPlanId({:campaignIds=>[$campaign_id]})
  #     response.status.should == 0
  #     response.desc.should == 'success'
  #     response.quota.should == 2
  #     response.rquota.should > 0
  #     expect{ApiResponse.verify(response.body)}.not_to raise_error
  #   end
  # end

  describe '#getAllCpcPlan' do
    it "getAllCpcPlan" do
      response = subject.getAllCpcPlan({})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
    end
  end
end