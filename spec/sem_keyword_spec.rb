require 'spec_helper'
describe Sogou::SEM::KeywordService do
  subject{Sogou::SEM::KeywordService.new($auth)}
  let(:keyword_sample){'XJK测试关键词o'}
  it "#addCpc #updateCpc #getCpcByCpcId #deleteCpc " do
    # ap subject.example('updateCpc')
# pending
    #addCpc
    # puts $adgroup_id
    keywordType = {:cpcGrpId => $adgroup_id,:cpc=>keyword_sample,:matchType => 1,:price => 1}
    response = subject.addCpc({:cpcTypes => [keywordType]})
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    keyword_id = response.body[:cpc_types][:cpc_id]

    #updateCpc
    keywordType = {:cpcId=> keyword_id,:price => 2}
    response = subject.updateCpc({:cpcTypes=>[keywordType]})
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0

    #getCpcByCpcId
    sleep 3
    response = subject.getCpcByCpcId({:cpcIds => [keyword_id]})
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    keyword = response.body[:cpc_types]
    (keyword.is_a?Hash).should == true
    keyword[:cpc_id].should == keyword_id
    keyword[:cpc_grp_id].should == $adgroup_id
    keyword[:cpc].should == keyword_sample
    keyword[:price].should == "2.0"

    #deleteCpc
    sleep 3
    response = subject.deleteCpc({:cpcIds => [keyword_id]})
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    # response.body[:result].should == '1'
  end
end
