describe 'DataTableScreen' do

  class TestDataTableScreenScope < ProMotion::DataTableScreen
    model Contributer, scope: :starts_with_s
  end

  class TestDataTableScreen < ProMotion::DataTableScreen
    model Contributer
  end

  def contributors
    %w{twerth squidpunch GantMan shreeve chunlea markrickert}
  end

  def init_contributors
    Contributer.destroy_all
    contributors.each do |c|
      Contributer.new(name: c)
    end
    cdq.save
  end

  before do
    init_contributors
    @controller = TestDataTableScreen.new
    @controller_s = TestDataTableScreenScope.new
  end

  it "should default the scope to all, if its not included in the cell definition" do
    @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == Contributer.count
  end

  it "should initialize like a normal PM::TableScreen cell" do
    path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell_data = @controller.cell_at(path)

    expected_keys = [:properties, :cell_style, :cell_identifier]
    (expected_keys & cell_data.keys).should == expected_keys

    @controller.tableView(@controller.table_view, cellForRowAtIndexPath: path).class.should == ContributerCell
  end

  it "should properly use scopes to generate cells" do
    @controller_s.tableView(@controller.table_view, numberOfRowsInSection: 0).should == Contributer.where(:name).begins_with('s').count
  end

  it "should sort by :created_at when the :all scope is not defined" do
    Contributer.sort_by(:created_at).each_with_index do |entity, index|
      path = NSIndexPath.indexPathForRow(index, inSection:0)
      cell_data = @controller.cell_at(path)
      cell_data[:properties][:name].should == entity.name
    end
  end

  it "should sort by the scope properly" do
    Contributer.where(:name).begins_with('s').sort_by(:name).each_with_index do |entity, index|
      path = NSIndexPath.indexPathForRow(index, inSection:0)
      cell_data = @controller_s.cell_at(path)
      cell_data[:properties][:name].should == entity.name
    end
  end

  describe "live reloading" do
    it "should delete cells when deleted form CoreData" do
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count
      Contributer.first.destroy
      cdq.save
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count - 1
    end

    it "should add cells when added to CoreData" do
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count
      Contributer.new(name: "clayallsopp") # a man can dream, can't he?
      cdq.save
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count + 1
      Contributer.new(name: "mattt")
      cdq.save
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count + 2
    end

    it "should update cells when data is changed in CoreData" do
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count

      path = NSIndexPath.indexPathForRow(2, inSection:0)
      cell_data = @controller.cell_at(path)
      name_to_change = cell_data[:properties][:name]

      # Change the name
      # Just append something to the name so we don't mess with
      # the order of the sorted cells.
      c = Contributer.where(name: name_to_change).first
      c.name = "#{name_to_change} new"

      cell_data = @controller.cell_at(path)
      cell_data[:properties][:name].should == "#{name_to_change} new"

      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count
    end
  end

  describe ".model" do
    it "should query the model that was provided to the screen" do
      TestDataTableScreen.model Contributer
      TestDataTableScreen.data_model.should.equal(Contributer)
    end

    it "should require the model provided defines the cell method" do
      class MissingCellMethod; end

      should.raise(RuntimeError) do
        TestDataTableScreen.model MissingCellMethod
      end
    end

    it "should accept an optional scope" do
      TestDataTableScreen.model Contributer, scope: :starts_with_s
      TestDataTableScreen.data_scope.should.equal(:starts_with_s)
    end
  end
end
