# FXFormViewController is a top level class
class FXFormViewController < UIViewController
end

# Defines which ProMotion classes handle delegates
module ProMotion
  class ViewController < UIViewController
    
    def class_handles_delegates?
      true
    end
    
  end

  class TableViewController < UITableViewController
    
    def class_handles_delegates?
      true
    end
    
  end

  # Include the entire class declaration chain for people that may not have
  # the ProMotion-form gem installed.
  class FormViewController < FXFormViewController
    
    def class_handles_delegates?
      true
    end
    
  end
end
