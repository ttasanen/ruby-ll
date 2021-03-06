require 'spec_helper'

describe LL::SourceLine do
  describe '#initialize' do
    before do
      @source_line = described_class.new('foo')
    end

    it 'sets the data' do
      @source_line.data.should == 'foo'
    end

    it 'sets the line number' do
      @source_line.line.should == 1
    end

    it 'sets the column' do
      @source_line.column.should == 1
    end

    it 'sets the file name' do
      @source_line.file.should == '(ruby)'
    end
  end

  describe '#source' do
    it 'returns the source code of the line' do
      line = described_class.new(<<-EOF.strip, 2, 3)
# Foo
  bar
      EOF

      line.source.should == '  bar'
    end

    it 'removes trailing whitespace' do
      line = described_class.new("foo\n")

      line.source.should == 'foo'
    end
  end

  describe '#==' do
    before do
      @line = described_class.new('foo', 1, 1)
    end

    it 'returns false when comparing SourceLine with a Fixnum' do
      @line.should_not == 10
    end

    it 'returns false if two SourceLine filenames do not match' do
      @line.should_not == described_class.new('foo', 1, 1, '(bar)')
    end

    it 'returns false if two SourceLine line numbers do not match' do
      @line.should_not == described_class.new('foo', 2, 1)
    end

    it 'returns false if two SourceLine column numbers do not match' do
      @line.should_not == described_class.new('foo', 1, 2)
    end

    it 'returns true if two SourceLine instances are equal' do
      @line.should == described_class.new('foo', 1, 1)
    end
  end
end
