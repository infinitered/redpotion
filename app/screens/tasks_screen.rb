class TasksScreen < PM::TableScreen
  title "Tasks"
  refreshable
  stylesheet TasksScreenStylesheet
  searchable placeholder: "Search tasks"

  def on_load
  end

  def on_refresh
  end

  def table_data
    [{
      title: "Tasks",
      cells: [
        {
          cell_class: TaskCell,
          properties: {
            my_title: "First task"
          },
          editing_style: :delete
        },
        {
          cell_class: TaskCell,
          properties: {
            my_title: "Second task"
          }
        }
      ]
    }]
  end

  # Remove if you are only supporting portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
