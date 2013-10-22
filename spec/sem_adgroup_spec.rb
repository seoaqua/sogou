require 'spec_helper'

describe Sogou::SEM::AdgroupService do
  subject{Sogou::SEM::AdgroupService.new($auth)}
  describe '#getAllCpcGrpId' do
    it "should return hash with correct format calling getAllCpcGrpId " do

      response = subject.getAllCpcGrpId
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      # response.class.should == Hash
      # response.should have_key :campaign_adgroup_ids
      # response = response[:campaign_adgroup_ids]
      # response.first.should have_key :campaign_id
      # response.first.should have_key :adgroup_ids
      # campaign_id = response.first[:campaign_id]
      # campaign_id.to_i.to_s.should == campaign_id
      # response.first[:adgroup_ids].class.should == Array
      # adgroup_id = response.first[:adgroup_ids].first
      # adgroup_id.to_i.to_s.should == adgroup_id
    end
  end

  describe '#getCpcGrpByCpcGrpId' do
    # subject{Sogou::SEM::AdgroupService.new($auth)}
    it "should return hash with correct format calling getCpcGrpByCpcGrpId" do
      response = subject.getCpcGrpByCpcGrpId({:cpcGrpIds=>[$adgroup_id]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
    end
  end

  describe '#getCpcGrpIdByCpcPlanId' do
    # subject{Sogou::SEM::AdgroupService.new($auth)}
    it "should return hash with correct format calling getCpcGrpIdByCpcPlanId" do
      response = subject.getCpcGrpIdByCpcPlanId({:cpcPlanIds=>[$campaign_id]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      # response.class.should == Hash
      # response.should have_key :campaign_adgroups
    end
  end

  # describe '#getAdgroupByAdgroupId' do
  #   # subject{Sogou::SEM::AdgroupService.new($auth)}
  #   it "should return hash with correct format calling getAdgroupByAdgroupId" do
  #     pending
  #     response = subject.getAdgroupByAdgroupId({:adgroupIds => $adgroup_ids})
  #     response.status.should == 0
  #     response.desc.should == 'success'
  #     response.quota.should == 2
  #     response.rquota.should > 0
  #     expect{ApiResponse.verify(response.body)}.not_to raise_error
  #   end
  # end

  describe '#addCpcGrp #updateCpcGrp #getCpcGrpByCpcGrpId #deleteCpcGrp' do
    # subject {Sogou::SEM::AdgroupService.new($aut)}
    it "is not ready yet" do
      #addCpcGrp
      adgroupType_add = {:cpcPlanId=>$campaign_id,:cpcGrpName=>'adgroupName1',:maxPrice=>2}

      response = subject.addCpcGrp({:cpcGrpTypes => [adgroupType_add]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # ap response.body
      # expect{ApiResponse.verify(response.body)}.not_to raise_error

      #parse and verify adgroup_id
      adgroup_id = response.body[:cpc_grp_types][:cpc_grp_id]
      adgroup_id.to_i.to_s.should == adgroup_id

      #updateCpcGrp
      adgroupType_update = {:cpcGrpId => adgroup_id, :cpcGrpName => 'adgroupName2'}
      # ap adgroupType
      response = subject.updateCpcGrp({:cpcGrpTypes=>[adgroupType_update]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # ap response.body
      # expect{ApiResponse.verify(response.body)}.not_to raise_error

      #getCpcGrpByCpcGrpId
      response = subject.getCpcGrpByCpcGrpId({:cpcGrpIds=>[adgroup_id]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should >= 0
      response.rquota.should > 0
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      # response.body[:adgroup_types][:adgroup_name].should == 'adgroupName2'


      #deleteCpcGrp
      response = subject.deleteCpcGrp({:cpcGrpIds => [adgroup_id]})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should > 0
      response.rquota.should > 0
      # ap response.body
      # expect{ApiResponse.verify(response.body)}.not_to raise_error
      # ap response.body
      # it "is not implemented yet" do
      #   pending("this is pending before we have testing-purpose account")
      # end
    end
  end

end
