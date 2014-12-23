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
    cell model: TestModel, scope: :starts_with_o, template: {
      name: :name,
      cell_class: TestCell
    }
  end

  it 'should set the cell_properties value when we call DataTableScreen.cell' do
    TestDataTableScreen.new.cell_properties[:model].should.equal(TestModel)
    TestDataTableScreen.new.cell_properties[:scope].should.equal(:starts_with_o)
    TestDataTableScreen.new.cell_properties[:template][:cell_class].should.equal(TestCell)
    TestDataTableScreen.new.cell_properties[:template][:name].should.equal(:name)
  end

  it 'should return items that can be used to build cells from cell_data' do
    TestDataTableScreen.new.cell_data.count.should.equal(1)
    TestDataTableScreen.new.cell_data[0][:properties][:name].should.equal('one')
  end

  it 'should default the scope to all, if its not included in the cell definition' do
    TestDataTableScreen.cell(model: TestModel, template: {
      name: :name,
      cell_class: TestCell
    })
    TestDataTableScreen.new.cell_data.count.should.equal(2)
    TestDataTableScreen.new.cell_data[0][:properties][:name].should.equal('one')
    TestDataTableScreen.new.cell_data[1][:properties][:name].should.equal('two')
  end
end
