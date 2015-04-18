# Formatting numbers and dates

A performant way to format numbers and dates.

```ruby
rmq.format.number(1232, '#,##0.##')
rmq.format.date(Time.now, 'EEE, MMM d, ''yy')
rmq.format.numeric_formatter(your_format_here) # returns cached numeric formatter
rmq.format.date_formatter(your_format_here) # returns cached date formatter
```
See <http://www.unicode.org/reports/tr35/tr35-19.html#Date_Format_Patterns> for more information about date format strings.
