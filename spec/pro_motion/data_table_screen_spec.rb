describe 'DataTableScreen' do
  class TestModel
    attr_accessor :name

    def initialize(name)
      self.name = name
    end

    def self.all
      [
        new('one'),
        new('two')
      ]
    end

    def self.starts_with_o
      [
        new('one')
      ]
    end

    def cell
      {
        cell_class: TestCell,
        properties: {
          name: self.name
        }
      }
    end
  end
  class TestCell
    def on_load
      find(self.contentView).tap do |q|
        @title = q.append!(UILabel)
      end
    end
    def name=(value)
      @title.text = value
    end
  end

  class TestDataTableScreen < ProMotion::DataTableScreen
    model TestModel, scope: :starts_with_o
  end

  it 'should return items that can be used to build cells from cell_data' do
    TestDataTableScreen.new.cell_data.count.should.equal(1)
    TestDataTableScreen.new.cell_data[0][:properties][:name].should.equal('one')
  end

  it 'should default the scope to all, if its not included in the cell definition' do
    class TestDataTableScreen < ProMotion::DataTableScreen
      model TestModel
    end

    TestDataTableScreen.new.cell_data.count.should.equal(2)
    TestDataTableScreen.new.cell_data[0][:properties][:name].should.equal('one')
    TestDataTableScreen.new.cell_data[1][:properties][:name].should.equal('two')
  end

  describe ".model" do
    it "should query the model that was provided to the screen" do
      TestDataTableScreen.model TestModel
      TestDataTableScreen.data_model.should.equal(TestModel)
      TestDataTableScreen.new.cell_data.count.should.equal(2)
    end

    it "should require the model provided defines the cell method" do
      class MissingCellMethod; end

      should.raise(RuntimeError) do
        TestDataTableScreen.model MissingCellMethod
      end
    end

    it "should accept an optional scope" do
      TestDataTableScreen.model TestModel, scope: :starts_with_o
      TestDataTableScreen.data_scope.should.equal(:starts_with_o)
      TestDataTableScreen.new.cell_data.count.should.equal(1)
      TestDataTableScreen.new.cell_data[0][:properties][:name].should.equal('one')
    end
  end
end
