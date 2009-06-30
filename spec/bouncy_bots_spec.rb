require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class MacroTest
  def self.before_filter(*args); end
end

class FilterTest
  def self.before_filter(*args); end
  def redirect_to(*args); end

  include BouncyBots
  bounce_bots :bounce_dest, :one, :two, :three

  attr_accessor :params
end

describe "BouncyBots" do
  before do
    MacroTest.stub!(:bouncy_settings)
  end

  describe ".bounce_bots macro" do
    it "sets the before filter" do
      MacroTest.should_receive(:before_filter).with(:bounce_bot)
      MacroTest.class_eval do
        include BouncyBots
        bounce_bots :bounce_to, :one, :two, :three
      end
    end

    it "breaks out options" do
      MacroTest.should_receive(:cattr_accessor).with(:bounce_to)
      MacroTest.should_receive(:cattr_accessor).with(:bounce_field)
      MacroTest.should_receive(:cattr_accessor).with(:bounce_field_parents)
      MacroTest.class_eval do
        include BouncyBots
        bounce_bots :bounce_to, :one, :two, :three
      end
    end
  end

  describe "#bounce_bot" do
    it "calls the bounce_to if the field is not blank" do
      filter = FilterTest.new
      filter.params = {:one => {:two => {:three => 'something'}}}
      filter.should_receive(:bounce_dest).and_return('bounced')
      filter.send(:bounce_bot)
    end

    it "does not call the bounce_to if the field is blank" do
      filter = FilterTest.new
      filter.params = {:one => {:two => {:three => nil}}}
      filter.should_not_receive(:bounce_dest)
      filter.send(:bounce_bot)
    end

    it "redirects if the field is not blank" do
      filter = FilterTest.new
      filter.params = {:one => {:two => {:three => 'something'}}}
      filter.stub!(:bounce_dest).and_return('bounced')
      filter.should_receive(:redirect_to).with('bounced')
      filter.send(:bounce_bot)
    end
  end
end
