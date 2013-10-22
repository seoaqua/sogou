require 'spec_helper'
describe Sogou::SEM::ReportService do
  subject{Sogou::SEM::ReportService.new($auth)}
    it 'should not raise error on #getReportId #getReportState #getReportPath series test' do
      pending('Report type and report range do not match')
      #getReportId
      options = {
        :performanceData => [Sogou::SEM::PerformanceData::IMPRESSION, Sogou::SEM::PerformanceData::CLICK, Sogou::SEM::PerformanceData::CPC],
        :startDate => (Time.now - 2*24*3600).utc.iso8601,
        :endDate => (Time.now - 24*3600).utc.iso8601,
        :statIds => [$campaign_id],
        :idOnly => true
        # :levelOfDetails => Sogou::SEM::LevelOfDetails::CAMPAIGN,
        # :reportType => Sogou::SEM::ReportType::CAMPAIGN,
        # :statRange => Sogou::SEM::StatRange::CAMPAIGN
      }

      response = subject.getReportId({:reportRequestType => options},true)
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should == 2
      response.rquota.should > 0

      #parse report_id
      report_id = response.body[:report_id]

      #getReportState
      try_count = 0
      loop do
        response = subject.getReportState({:reportId => report_id})
        response.status.should == 0
        response.desc.should == 'success'
        response.quota.should == 2
        response.rquota.should > 0
        #verify is_generated status
        is_generated = response.body[:is_generated]
        break if is_generated == '3' or try_count > 10
        sleep 1
        try_count +=1
      end


      #getReportPath
      response = subject.getReportPath({:reportId => report_id})
      response.status.should == 0
      response.desc.should == 'success'
      response.quota.should == 2
      response.rquota.should > 0

    end

    it "处理过期/无效id,应返回false" do
      expect{subject.getReportState({:reportId=>'7da8438bc705c9e6e747959fafce91f2'}).body}.to raise_error
      expect{subject.getReportState({:reportId=>'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'}).body}.to raise_error
    end
end