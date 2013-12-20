module Sogou
  module SEM

    module Format
      CSV = 1
    end

    module ReportState
      DOING = 0 #处理中
      DONE = 1 #处理成功
      ERROR =-1 #报表生成异常
    end

    module PerformanceData
      COST = 'cost' #消费
      CPC = 'cpc' #每个点击的消费
      CLICK = 'click' #点击数
      IMPRESSION = 'impression' #展示量
      CTR = 'ctr' #转化率
      # CPM = 'cpm' #?
      # POSITION = 'position' #？
      # CONVERSION = 'conversion' #?
    end

    # module LevelOfDetails
    #   PORTFOLIO = 2 #账户粒度
    #   CAMPAIGN = 3 #计划粒度
    #   ADGROUP = 5 #单元粒度
    #   CREATIVE = 7 #创意粒度
    #   KEYWORDID = 11 #关键词(keywordid)粒度
    #   KEYWORD = 12 #关键词(keywordid)+创意粒度
    # end

    module ReportType
      PORTFOLIO = 1 #账户
      CAMPAIGN = 2 #计划
      ADGROUP = 3 #单元
      KEYWORDID = 5 #关键词(keywordid)
      CREATIVE = 4 #创意
      QUERY = 6 #搜索词
    end

    module StatRange #注意:统计范围不能细于当前的统计 粒度,例如统计粒度为计划,则统计 范围不能细到单元
      PORTFOLIO = 1 #账户范围
      CAMPAIGN = 2 #计划范围
      ADGROUP = 3 #单元范围
      CREATIVE = 4 #创意范围
      KEYWORDID = 5 #关键词(keywordid)范围
    end

    module UnitOfTime
      DAY = 1 #分日
      WEEK = 2 #分周
      MONTH = 3 #分月
    end

    module Device
      ALL = 0 #全部搜索推广设备
      PC = 1 #仅计算机
      MOBILE = 2 #仅移动 ￼
    end
  end
end