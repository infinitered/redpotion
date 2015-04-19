<img src="./_art/screen.png" alt="Screen Shot" width="500" />

**Did you know that UIAlertView and UIActionSheet (as well as their respective delegate protocols) are deprecated in iOS 8?**

Apple requests you start using the new `UIAlertController`.  RedPotion supports for antiquated `UIAlertView`s for the gnostalgic.

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

## Classic UIAlertView Helpers

If you'd like to still support pre-iOS8, you can easily use `app.alert_view` with a similar syntax, and instead of actions you'll used the predefined delegates.

**`UIAlertView` Classic:**
```ruby
  # support the elderly
  app.alert_view("Hey look at this old trick")
 
  # Still feels like magic!
  app.alert_view({
    title: "Hey There",
    message: "Check out this complex alert!",
    cancel_button: 'Nevermind',
    other_buttons: ['Log In'],
    delegate: nil,
    view_style: UIAlertViewStyleLoginAndPasswordInput
  })  
```
