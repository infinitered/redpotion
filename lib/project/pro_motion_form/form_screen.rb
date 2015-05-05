module ProMotion
  class FormScreen
    # Defining this here is critical for PM::FormScreens to not fire delegate
    # methods twice. This class must be defined even if we aren't using
    # the ProMotion-form gem so that our pm_handles_delegates? method
    # works properly for those people who _do_ use PM::FormScreen
  end
end
