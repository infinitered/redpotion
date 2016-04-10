class TestTableScreen < PM::TableScreen
  
  include DelegateTestAttributes
  def table_data; @table_data ||= []; end
  
end
