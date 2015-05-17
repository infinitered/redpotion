Provided by the RedAlert Gem, which is included in RedPotion
<img src="https://raw.githubusercontent.com/GantMan/RedAlert/master/_art/demo.gif" alt="Screen Shot" width="500" />

**Did you know that UIAlertView and UIActionSheet (as well as their respective delegate protocols) are deprecated in iOS 8?**

Apple requests you start using the new `UIAlertController`.  RedPotion gives you a clean way to use `UIAlertController`s that will automatically fail over to `UIAlertView` and `UIActionSheet` for iOS 7.

## Usage

```ruby

  # Simply do an alert
  app.alert("Minimal Alert")

  # Alert with callback
  app.alert("Alert with Block") {
    puts "Alert with Block worked!"
  }

  # Modify some snazzy options
  app.alert(title: "New Title", message: "Great message", animated: false)

  # Switch it to look like an ActionSheet by setting the style
  app.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet) do |action_type|
    puts "You clicked #{action_type}"
  end

  # Utilize common templates
  app.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) do |action_type|
    case action_type
    when :yes
      puts "Here's your Sandwich!"
    when :no
      puts "FINE!"
    end
  end
```

You can pass in symbols or strings and we'll build the buttons for you:

```ruby
rmq.app.alert title: "Hey!", actions: [ "Go ahead", :cancel, :delete ] do |button_tag|
  case button_tag
  when :cancel then puts "Canceled!"
  when :delete then puts "Deleted!"
  when "Go ahead" then puts "Going ahead!"
  end
end
```

You can even use the `make_button` helper to create custom UIAction buttons to add:
```ruby
  # Use custom UIAction buttons and add them
  taco = app.make_button("Taco") {
            puts "Taco pressed"
          }
  nacho = app.make_button(title: "Nacho", style: :destructive)  {
            puts "Nacho pressed"
          }
  button_list = [taco, nacho]
  app.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list)
```

## Available Templates

Templates are provided [HERE](https://github.com/GantMan/RedAlert/blob/master/lib/project/button_templates.rb)
* `:yes_no` = Simple yes and no buttons.
* `:yes_no_cancel` = Yes/no buttons with a separated cancel button.
* `:ok_cancel` = OK button with a separated cancel button.
* `:delete_cancel` = Delete button (red) with a separated cancel button.

_More to come:_ be sure to submit a pull-request with your button template needs.

## More info

Feel free to read up on UIAlertController to see what all is wrapped up in this gem.
* [Hayageek](http://hayageek.com/uialertcontroller-example-ios/)
* [NSHipster](http://nshipster.com/uialertcontroller/)


