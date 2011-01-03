include UTA::Models

describe Transaction do
  describe ".generate" do
    it "should produce a new Transaction" do
      Transaction.generate.should be_a(Transaction)
    end

    it "should generate a UUID" do
      tr = Transaction.generate
      tr.subject.fragment.should =~ /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/
      tr.id.should be_a(RDF::URI)
      tr.id.to_s.should =~ /^urn:uuid:/
    end

    it "should set a default date" do
      Date.should_receive(:today) { Date.civil(2010, 12, 15) }
      tr = Transaction.generate
      tr.date.should == Date.civil(2010, 12, 15)
    end
  end
end
