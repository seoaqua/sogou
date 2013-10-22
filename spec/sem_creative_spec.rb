require 'spec_helper'
require 'uri'
describe Sogou::SEM::CreativeService do
  subject{Sogou::SEM::CreativeService.new($auth)}
  let(:new_title){'新测试创意标题b'}
  it '#addCpcIdea #updateCpcIdea #getCpcIdeaByCpcGrpId #deleteCreative' do
    # ap subject.operations
    # ap subject.example('deleteCpcIdea')
    # pending
    #addCpcIdea
    creativeType = {
      :cpcGrpId => $adgroup_id,
      :title => '测试创意标题d',
      :description1 => '测试创意首行测试创意首行测试创意首行',
      :description2 => '测试创意次行测试创意次行测试创意次行',
      :visitUrl => $pcDestinationUrl,
      :showUrl=> URI($pcDestinationUrl).host,
      :mobileVisitUrl => $mobileDestinationUrl,
      :mobileShowUrl=> URI($mobileDestinationUrl).host
    }
    # {:creativeTypes=>[{
    #   :creativeId=>"long",
    #   :adgroupId=>"long",
    #   :title=>"string",
    #   :description1=>"string",
    #   :description2=>"string",
    #   :pcDestinationUrl=>"string",
    #   :pcDisplayUrl=>"string",
    #   :mobileDestinationUrl=>"string",
    #   :mobileDisplayUrl=>"string",
    #   :pause=>"boolean",
    #   :status=>"int"}]
    #   }
    # }

    # puts subject.example('addCpcIdea')
    response = subject.addCpcIdea({:cpcIdeaTypes => [creativeType]})
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    # expect{ApiResponse.verify(response.body)}.not_to raise_error
    creative_id = response.body[:cpc_idea_types][:cpc_idea_id]


    # updateCpcIdea
    sleep 3
    creativeType = {
      :cpcIdeaId=>creative_id,
      :title => new_title,
      :description1 => '艺龙酒店测试创意首行测试创意首行测试创意首行',
      :description2 => '艺龙酒店测试创意首行测试创意首行测试创意次行',
      :visitUrl => 'http://hotel.elong.com/beijing/'
    }
    response = subject.updateCpcIdea(:cpcIdeaTypes => [creativeType])
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    ap response.body
    # expect{ApiResponse.verify(response.body)}.not_to raise_error

    #getCpcIdeaByCpcGrpId
    sleep 3
    response = subject.getCpcIdeaByCpcGrpId(:cpcGrpIds => [creative_id])
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    ap response.body
    response.body[:cpc_idea_types][:title].should == new_title
    # expect{ApiResponse.verify(response.body)}.not_to raise_error

    #deleteCpcIdea
    response = subject.deleteCpcIdea({:cpcIdeaIds => [creative_id]})
    response.status.should == 0
    response.desc.should == 'success'
    response.quota.should == 1
    response.rquota.should > 0
    # expect{ApiResponse.verify(response.body)}.not_to raise_error
  end

end
