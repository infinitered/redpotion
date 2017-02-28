# -*- encoding: utf-8 -*-
# stub: redpotion 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "redpotion"
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Infinite Red"]
  s.date = "2017-02-20"
  s.description = "RedPotion - The best combination of RubyMotion tools and libraries"
  s.email = ["hello@infinite.red"]
  s.executables = ["potion"]
  s.files = ["README.md", "bin/potion", "lib/project/ext/kernel.rb", "lib/project/ext/object.rb", "lib/project/ext/pm_delegate.rb", "lib/project/ext/ui_collection_view_cell.rb", "lib/project/ext/ui_color.rb", "lib/project/ext/ui_image_view.rb", "lib/project/ext/ui_table_view_cell.rb", "lib/project/ext/ui_view.rb", "lib/project/ext/ui_view_controller.rb", "lib/project/pro_motion/collection_screen.rb", "lib/project/pro_motion/data_table.rb", "lib/project/pro_motion/data_table_screen.rb", "lib/project/pro_motion/data_table_search_delegate.rb", "lib/project/pro_motion/data_table_searchable.rb", "lib/project/pro_motion/screen.rb", "lib/project/pro_motion/support.rb", "lib/project/pro_motion/table.rb", "lib/project/ruby_motion_query/app.rb", "lib/project/ruby_motion_query/stylers/ui_image_view.rb", "lib/project/ruby_motion_query/traverse.rb", "lib/project/version.rb", "lib/redpotion.rb", "templates/collection_view_screen/app/screens/name_screen.rb", "templates/collection_view_screen/app/stylesheets/name_cell_stylesheet.rb", "templates/collection_view_screen/app/stylesheets/name_screen_stylesheet.rb", "templates/collection_view_screen/app/views/name_cell.rb", "templates/collection_view_screen/spec/screens/name_screen_spec.rb", "templates/collection_view_screen/spec/views/name_cell_spec.rb", "templates/metal_table_screen/app/screens/name_screen.rb", "templates/metal_table_screen/app/stylesheets/name_screen_stylesheet.rb", "templates/metal_table_screen/app/views/name_cell.rb", "templates/metal_table_screen/spec/screens/name_screen_spec.rb", "templates/screen/app/screens/name_screen.rb", "templates/screen/app/stylesheets/name_screen_stylesheet.rb", "templates/screen/spec/screens/name_screen_spec.rb", "templates/table_screen_cell/app/stylesheets/name_stylesheet.rb", "templates/table_screen_cell/app/views/name.rb", "templates/table_screen_cell/spec/views/name.rb", "templates/view/app/stylesheets/name_stylesheet.rb", "templates/view/app/views/name.rb", "templates/view/spec/views/name.rb"]
  s.homepage = "http://redpotion.org"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "RedPotion combines RMQ, ProMotion, CDQ, AFMotion, and more for the perfect mix to develop in RubyMotion fast"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby_motion_query>, [">= 1.7.0"])
      s.add_runtime_dependency(%q<ProMotion>, [">= 2.5.0"])
      s.add_runtime_dependency(%q<motion_print>, [">= 0"])
      s.add_runtime_dependency(%q<motion-cocoapods>, [">= 0"])
      s.add_runtime_dependency(%q<RedAlert>, [">= 0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<webstub>, [">= 0"])
    else
      s.add_dependency(%q<ruby_motion_query>, [">= 1.7.0"])
      s.add_dependency(%q<ProMotion>, [">= 2.5.0"])
      s.add_dependency(%q<motion_print>, [">= 0"])
      s.add_dependency(%q<motion-cocoapods>, [">= 0"])
      s.add_dependency(%q<RedAlert>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<webstub>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby_motion_query>, [">= 1.7.0"])
    s.add_dependency(%q<ProMotion>, [">= 2.5.0"])
    s.add_dependency(%q<motion_print>, [">= 0"])
    s.add_dependency(%q<motion-cocoapods>, [">= 0"])
    s.add_dependency(%q<RedAlert>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<webstub>, [">= 0"])
  end
end
