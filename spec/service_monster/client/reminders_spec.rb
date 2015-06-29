require 'spec_helper'

RSpec.describe ServiceMonster::Client::Reminders do

  before do
    @client = ServiceMonster::Client.new
  end

  describe '#reminders' do

    it 'should return a list of reminders' do
      stub_get("reminders").to_return(body: fixture('reminders_list.json'),
                                 headers: { content_type: "application/json; charset=utf-8",
                                            authorization: 'Basic blah'})

      @client.reminders

      expect(a_get("reminders")).to have_been_made
    end

    it "should return a filtered reminder list by date" do
      stub_get("reminders?wField=actualDateTimeEnd&wOperator=gt&wValue=2015-03-20")
        .to_return(body: fixture('filtered_reminders_list.json'),
                   headers: { content_type: "application/json; charset=utf-8",
                              authorization: 'Basic blah'})

      @client.reminders(wField: "actualDateTimeEnd", wOperator: "gt", wValue: "2015-03-20")

      expect(a_get("reminders?wField=actualDateTimeEnd&wOperator=gt&wValue=2015-03-20")).to have_been_made
    end
  end
end
