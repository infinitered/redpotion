# Validating data, text, text boxes, etc

RedPotion allows a RubyMotion validation library to help you to validate data in a way that makes life easy.

There are two main aspects, so you can utilize RMQ validation to meet your needs:
<ul>
	<li><strong>Validation Utility</strong> - Simple validation methods</li>
	<li><strong>RMQ Validation Selection Rules</strong> - Dynamically apply validation rules to input</li>
</ul>
QUICK EXAMPLES:
```ruby
# Examples of the Utility
rmq.validation.valid?('https://www.infinitered.com', :url) #true
rmq.validation.valid?(98.6, :number) #true

# Examples of Selection Rules
rmq.append(UITextField, :user).validates(:email)
rmq.append(UITextField, :password).validates(:strong_password)
rmq.append(UITextField, :pin).validates(:digits).validates(:length, exact_length: 5)

rmq(UITextField).valid? # checks if selected is valid
rmq(:password).clear_validations! #removes validations on selected
```

All validations are tied to RMQ Debugging mode. So you can turn them off in the application by entering debug mode. You can do so by starting your project with the flag set to true `rake rmq_debug=true` OR by setting the flag in the code/REPL with `RubyMotionQuery::RMQ.debugging = true`.

This allows you to quickly disable validation in your entire application during debugging.
<h2>RMQ Validation Utility</h2>
RMQ Comes with a simple utility to validate common forms of data input. Each validation type can support options specific to that validation rule.

**The following validation types are baked in for the utility:**
<ul>
	<li><strong>:email</strong> - Email address</li>
	<li><strong>:url</strong> - URL (<em>including http(s)</em>)</li>
	<li><strong>:dateiso</strong> - ISO Date <em>e.g. '2014-03-02'</em></li>
	<li><strong>:number</strong> - Any Real number <em>e.g. 62.5</em></li>
	<li><strong>:digits</strong> - Any Natural numbers <em>e.g. 65</em></li>
	<li><strong>:ipv4</strong> - IPV4 addresses</li>
	<li><strong>:time</strong> - Military time</li>
	<li><strong>:uszip</strong> - US Zip code with optional extended 4</li>
	<li><strong>:ukzip</strong> - UK postal code</li>
	<li><strong>:usphone</strong> - US 7 OR 10 digit phone number with dots, dashes, or spaces for separators</li>
	<li><strong>:strong_password</strong> - Any string of at least 8 characters comprised of numbers, uppercase, and lowercase input</li>
	<li><strong>:has_upper</strong> - True if any uppercase letters</li>
	<li><strong>:has_lower</strong> - True if any lowercase letters</li>
	<li><strong>:presence</strong> - True with any non-whitespace input</li>
	<li><strong>:length</strong> - Allows you to validate length restrictions on input</li>
	<li><strong>:custom</strong> - Validates using whatever is passed in the `regex` parameter</li>
</ul>
Most of these are built from a collection of `regular expressions` that are fed into a `regex_match?` method. You can send a pull-request or use the `custom` rule to handle your own validations.
```ruby
# examples
rmq.validation.valid?('test@test.com', :email) # returns true

rmq.validation.valid?('5045558989', :usphone) # returns true

rmq.validation.valid?('K1A 0B1', :uszip) # returns false

# Length takes a wide selection of input to facilitate your length validation needs
rmq.validation.valid?('test', :length, exact_length: 4) #true
rmq.validation.valid?('test', :length, min_length: 4) #true
rmq.validation.valid?('test', :length, max_length: 4) #true
# ranges
rmq.validation.valid?('test', :length, min_length: 2, max_length: 7) #true
rmq.validation.valid?('test', :length, exact_length: 2..7) #true
# strip whitespace
rmq.validation.valid?(' test ', :length, max_length: 5, strip: true) #true

# roll your own validation rule
rmq.validation.valid?('nacho', :custom, regex: Regexp.new('nachos?')) #true (could also do /nachos?/ notation
```

### Universal Options
Some validation optinos are unique to that particular validation rule, but all validation rules have the following <strong>Universal Options</strong>:
#### allow_blank
By default all these tools are strict, but you can set the `allows_blank` option to true, which will cause a particular validation to return true IF it the input is blank. This can be useful in situations where data is optional.
<blockquote>e.g. Only validate weight is numeric if they entered a value for it.</blockquote>
#### white_list
In some situations you may have an outlying exception to the validation rule. Exceptions can be validated as true using the `white_list` parameter:
```ruby
rmq.validation.valid?(some_url_input, :url, white_list: ['http://localhost:8080', 'http://localhost:3000'])
# => true for 'http://localhost:3000' even though it's not going to pass URL (missing TLD)
```
<h2>RMQ Validation Selection Rules</h2>
For a more robust use of RMQ and validation, there's an arsenal of RMQ integrated validation options and events. ANY utility rule can be used in a selection validation. Simply chain the validation you'd like applied to the UIViews you've selected with RMQ. For example:
```ruby
# attach validation rules to UIViews
rmq.append(UITextField, :weight).validates(:digits)
rmq.append(UITextField, :name).validates(:presence)

# Later, you can check these fields to see if they have data that fits their associated validations
rmq(UITextField).valid?
```
Using the selection rules gets you a lot of validation help.
```ruby
# Get a list of all views that were valid/invalid (updates on every .valid? call)
rmq(some_selection_criteria).invalid # returns all invalid views in the selected
rmq(some_selection_criteria).valid # returns all valid views in the selected

# you can remove validations just as easily
rmq(some_selection).clear_validations!
```
You can attach and fire events on the UIViews in a block.
```ruby
rmq.append(UITextField).validates(:digits).
on(:valid) do |valid|
puts "This field is valid"
end.
on(:invalid) do |invalid|
puts "This field is invalid"
end

# The above will fire their events when validation gets called
rmq.all.valid?
# You can can call valid? during .on(:change) if you'd like your valid/invalid
# blocks to run instantaneously with given input.
```
Also, you can even get friendly error messages
```ruby
# start off with a validated input
rmq.append(UITextField, :user).validates(:email)
rmq.all.valid? #run validation check

# Returns array of error messages for every invalid item in selection
rmq.all.validation_errors
# E.G ["Validation Error - input requires valid email."]
```
You can customize these error messages per validation rule by setting them in the stylesheet
```ruby
# here in the stylesheet for this controller
def user(st)
st.validation_errors = {
email: "Please check your user email, and try again"
}
end
```

## How do I add my own validations?
There are a few excellent ways to add your own validations. If you simply need to make exceptions for existing validations, consider looking into using `white_list`. If you need to use your own custom regex or validation code, then the following 2 methods are extremely useful.

#### custom rule
If your validation is specific to a single form, we suggest taking advantage of using the `custom` validation rule.
```ruby
some_field = rmq.append(UITextField).validates(:custom, regex: /^test$/)
some_field.data("test")
some_field.valid?
# => true
```

#### add_validator
You can add your own validation with the `add_validator` method (Perhaps in your Application Stylesheet setup). Additionally, you're not limited to the bounds of a single regex. You can use the ruby methods you know and understand, as well as multiple parameters passed in `opts`.
```ruby
rmq.validation.add_validator(:start_with) do |value, opts|
value.start_with?(opts[:prefix])
end
```
You can then use your new validator in your application:
```ruby
some_field = rmq.append(UITextField).validates(:start_with, prefix: 'x')
some_field.data("test")
some_field.valid? # => false
some_field.data("xenophobia")
some_field.valid? # => true
```

*If you find yourself needing a particular validation rule often, please patch back to RMQ's default rules with a Pull Request!*
