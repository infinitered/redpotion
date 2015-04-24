describe 'DataTableScreen' do

  class TestDataTableScreenScope < ProMotion::DataTableScreen
    model Contributer, scope: :starts_with_s
  end

  class TestDataTableScreen < ProMotion::DataTableScreen
    model Contributer
  end

  def init_contributors
    Contributer.destroy_all
    %w{twerth squidpunch GantMan shreeve chunlea markrickert}.each do |c|
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
    @controller.tableView(@controller.table_view, cellForRowAtIndexPath: NSIndexPath.indexPathForRow(0, inSection:0)).class.should == ContributerCell
  end

  it "should properly use scopes to generate cells" do
    @controller_s.tableView(@controller.table_view, numberOfRowsInSection: 0).should == Contributer.where(:name).begins_with('s').count
  end

  it "should have correct cell definition data" do
    # For :all scope
    Contributer.sort_by(:name).each_with_index do |entity, index|
      path = NSIndexPath.indexPathForRow(index, inSection:0)
      cell_data = @controller.cell_at(path)
      cell_data[:properties][:name].should == entity.name
    end

    # For :starts_with_s scope
    Contributer.where(:name).begins_with('s').sort_by(:name).each_with_index do |entity, index|
      path = NSIndexPath.indexPathForRow(index, inSection:0)
      cell_data = @controller_s.cell_at(path)
      cell_data[:properties][:name].should == entity.name
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
