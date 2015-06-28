require 'spec_helper'

RSpec.describe ServiceMonster::Client::Jobs do

  before do
    @client = ServiceMonster::Client.new
  end

  describe '#jobs' do

    it 'should return a list of jobs' do
      stub_get("jobs").to_return(body: fixture('jobs_list.json'),
                                 headers: { content_type: "application/json; charset=utf-8",
                                            authorization: 'Basic blah'})

      @client.jobs

      expect(a_get("jobs")).to have_been_made
    end

    it "should return a filtered job list by date" do
      stub_get("jobs?wField=actualDateTimeEnd&wOperator=gt&wValue=2015-03-20")
        .to_return(body: fixture('filtered_job_list.json'),
                   headers: { content_type: "application/json; charset=utf-8",
                              authorization: 'Basic blah'})

      @client.jobs(wField: "actualDateTimeEnd", wOperator: "gt", wValue: "2015-03-20")

      expect(a_get("jobs?wField=actualDateTimeEnd&wOperator=gt&wValue=2015-03-20")).to have_been_made
    end

  end
end
