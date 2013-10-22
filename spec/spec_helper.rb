require 'Sogou'
require 'time'
#请根据自己实际情况填写
$username = '' #用户名
$password = '' #密码
$token = '' #token
$auth = Sogou::Auth.new
$auth.username = $username
$auth.password = $password
$auth.token = $token
$startDate = (Time.now - 24*3600).utc.iso8601
$endDate = Time.now.utc.iso8601
$pcDestinationUrl = 'http://www.elong.com/'
$mobileDestinationUrl = 'http://www.elong.com/'


cs = Sogou::SEM::CampaignService.new($auth)
campaigns = cs.getAllCpcPlan
campaign = campaigns.body[:cpc_plan_types].first
$campaign_id = campaign[:cpc_plan_id]
$campaign_name = campaign[:cpc_plan_name]

ac = Sogou::SEM::AdgroupService.new($auth)

adgroups = ac.getCpcGrpByCpcPlanId({:cpcPlanIds=>[$campaign_id]})
$adgroup_id = adgroups.body[:cpc_plan_grps][:cpc_grp_types].first[:cpc_grp_id]
