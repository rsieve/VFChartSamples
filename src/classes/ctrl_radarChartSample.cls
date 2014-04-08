public with sharing class ctrl_radarChartSample {
	
	public list<OppSummaryData> summaryData {get;set;}
	
	public ctrl_radarChartSample(){
		updateOpportunityData();
	}
	
	public void updateOpportunityData(){
		summaryData = new List<OppSummaryData>();
		List<AggregateResult> arOppData = [SELECT stageName stage, SUM(amount) amount, AVG(probability) prob
											FROM Opportunity
											GROUP BY stageName];
		for(AggregateResult ar : arOppData){
			summaryData.add(new OppSummaryData((string)ar.get('stage'), (decimal)ar.get('amount'), (decimal)ar.get('prob')));
		}
	}
	
	public class OppSummaryData {
		public string stage {get;set;}
		public decimal totalAmount {get;set;}
		public decimal probability {get;set;}
		public decimal weightedRevenue {get;set;}
		
		public OppSummaryData(string tmpStage, decimal tmpTotalAmount, decimal tmpProbability){
			stage = tmpStage;
			totalAmount = tmpTotalAmount;
			probability = tmpProbability;
			weightedRevenue = totalAmount * probability/100;
		}
	}
}