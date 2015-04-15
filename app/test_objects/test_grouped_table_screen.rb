class TestGroupedTableScreen < PM::GroupedTableScreen
  include DelegateTestAttributes
  def table_data; @table_data ||= []; end
end
