require 'spec_helper'
require 'rspec/core/formatters/progress_formatter'

RSpec.describe RSpec::Core::Formatters::ProgressFormatter do

  let(:output)       { StringIO.new }
  let(:formatter)    { RSpec::Core::Formatters::ProgressFormatter.new output }
  let(:notification) { double "notifcation", :example => double }

   before do
     formatter.start double(:count => 2)
     allow(formatter).to receive(:color_enabled?).and_return(false)
   end

   it "produces line break on start dump" do
     formatter.start_dump notification
     expect(output.string).to eq("\n")
   end

   it 'prints a . on example_passed' do
     formatter.example_passed notification
     expect(output.string).to eq(".")
   end

   it 'prints a * on example_pending' do
     formatter.example_pending notification
     expect(output.string).to eq("*")
   end

   it 'prints a F on example_failed' do
     formatter.example_failed notification
     expect(output.string).to eq("F")
   end

   it "produces standard summary without pending when pending has a 0 count" do
     formatter.start_dump notification
     formatter.dump_summary double("summary", :duration => 0.00001, :examples => 2, :failures => 0, :pending => 0)
     expect(output.string).to match(/2 examples, 0 failures/i)
     expect(output.string).not_to match(/0 pending/i)
   end

   it "pushes nothing on start" do
     formatter.start double(:count => 4)
     expect(output.string).to eq("")
   end

end
