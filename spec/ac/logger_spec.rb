require 'spec_helper'
require 'tempfile'

describe AC::Logger do
  let(:logfile) { Tempfile.new(File.basename(__FILE__)) }

  it 'has a version number' do
    expect(AC::Logger::VERSION).to match(/^\d+.\d+.\d+$/)
  end

  it "finds module & class" do
    expect(AC::Logger).to be_kind_of(Module)
    expect(AC::Logger::Instance).to be_kind_of(Class)
  end

  it 'defines level name lookup map' do
    expect(AC::Logger::Levels).to be_kind_of(Hash)
    expect(AC::Logger::Levels['info']).to eq(::Logger::INFO)
  end

  it 'hacks the module name' do
    pending('module named AC now, name hack not working elsewhere')
    expect(AC).to be(Ac)
  end

  describe "default Logger" do
    let(:log) { AC::Logger[logfile.path] }

    it "has a default 'W' log level" do
      log.info(self.to_s)
      expect(line = logfile.read).not_to be_nil
      expect(line).to eq('') # info logging is not reaching the file

      log.warn(self.to_s)
      expect(line = logfile.read).not_to be_nil
      expect(line).to match(/ W #{self.to_s}/)
    end
  end

  describe "debug level Logger" do
    let(:log) { AC::Logger[logfile.path, ::Logger::DEBUG] }

    it "logs execeptions with callstacks" do
      raise("foo") rescue log.ex($!, "bar")
      expect(txt = logfile.read).not_to be_nil
      expect(txt).to match(/ E foo: bar/)
      expect(txt).to match(/ D foo -> \(callstack\):\n/)
      expect(txt).to match(/#{__FILE__}:#{__LINE__ - 4}/)
    end
  end
end
