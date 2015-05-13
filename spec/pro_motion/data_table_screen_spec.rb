def contributors
  %w{twerth squidpunch GantMan shreeve chunlea markrickert}
end

def init_contributors
  Contributor.destroy_all
  contributors.each do |c|
    Contributor.new(name: c)
  end
  cdq.save
end

describe 'DataTableScreen' do

  class TestDataTableScreenScope < ProMotion::DataTableScreen
    model Contributor, scope: :starts_with_s
  end

  class TestDataTableScreen < ProMotion::DataTableScreen
    model Contributor
    refreshable
    attr_accessor :refreshed

    def on_refresh
      @refreshed = true
    end
  end

  before do
    init_contributors
    @controller = TestDataTableScreen.new
    @controller.on_load

    @controller_s = TestDataTableScreenScope.new
    @controller_s.on_load
  end

  it "should default the scope to all, if its not included in the cell definition" do
    @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == Contributor.count
  end

  it "should initialize like a normal PM::TableScreen cell" do
    path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell_data = @controller.cell_at(path)

    expected_keys = [:properties, :cell_style, :cell_identifier]
    (expected_keys & cell_data.keys).should == expected_keys

    @controller.tableView(@controller.table_view, cellForRowAtIndexPath: path).class.should == ContributorCell
  end

  it "should properly use scopes to generate cells" do
    @controller_s.tableView(@controller.table_view, numberOfRowsInSection: 0).should == Contributor.where(:name).begins_with('s').count
  end

  it "should sort by :created_at when the :all scope is not defined" do
    Contributor.sort_by(:created_at).each_with_index do |entity, index|
      path = NSIndexPath.indexPathForRow(index, inSection:0)
      cell_data = @controller.cell_at(path)
      cell_data[:properties][:name].should == entity.name
    end
  end

  it "should sort by the scope properly" do
    Contributor.where(:name).begins_with('s').sort_by(:name).each_with_index do |entity, index|
      path = NSIndexPath.indexPathForRow(index, inSection:0)
      cell_data = @controller_s.cell_at(path)
      cell_data[:properties][:name].should == entity.name
    end
  end

  describe "live reloading" do
    it "should delete cells when deleted form CoreData" do
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count
      Contributor.first.destroy
      cdq.save
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count - 1
    end

    it "should add cells when added to CoreData" do
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count
      Contributor.new(name: "clayallsopp") # a man can dream, can't he?
      cdq.save
      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count + 1
      Contributor.new(name: "mattt")
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
      c = Contributor.where(name: name_to_change).first
      c.name = "#{name_to_change} new"

      cell_data = @controller.cell_at(path)
      cell_data[:properties][:name].should == "#{name_to_change} new"

      @controller.tableView(@controller.table_view, numberOfRowsInSection: 0).should == contributors.count
    end

    describe "refreshable" do
      it "should be refreshable" do
        @controller.class.get_refreshable.should == true
      end

      it "should create a refresh object" do
        @controller.instance_variable_get("@refresh_control").should.be.kind_of UIRefreshControl
      end

      it "should respond to start_refreshing and end_refreshing" do
        @controller.respond_to?(:start_refreshing).should == true
        @controller.respond_to?(:end_refreshing).should == true
      end

      it "should call on_refresh" do
        @controller.refreshed.should.be.nil
        @controller.refreshView(UIRefreshControl.alloc.init)
        @controller.refreshed.should == true
      end
    end
  end

  describe ".model" do
    it "should query the model that was provided to the screen" do
      TestDataTableScreen.model Contributor
      TestDataTableScreen.data_model.should.equal(Contributor)
    end

    it "should require the model provided defines the cell method" do
      class MissingCellMethod; end

      should.raise(RuntimeError) do
        TestDataTableScreen.model MissingCellMethod
      end
    end

    it "should accept an optional scope" do
      TestDataTableScreen.model Contributor, scope: :starts_with_s
      TestDataTableScreen.data_scope.should.equal(:starts_with_s)
    end
  end
end
