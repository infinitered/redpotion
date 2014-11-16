# RedPotion

RedPotion combines [RMQ](http://rubymotionquery.com/), [ProMotion](https://github.com/clearsightstudio/ProMotion), [CDQ](https://github.com/infinitered/cdq), [AFMotion](https://github.com/clayallsopp/afmotion), and other libraries. It also adds new features to better integrate RMQ with ProMotion.

Its goals are to choose standard libraries and promote best practices, allowing you to developed iOS apps in record time.

The **makers of RMQ** at [InfiniteRed](http://infinitered.com/) and the **creators of ProMotion** at [ClearSight Studio](https://clearsightstudio.com/) have teamed up to create the ultimate RubyMotion library.

[![image](https://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/11/2013/08/InfiniteRed_logo_100h.png)](http://infinitered.com/)

[![image](https://clearsightstudio.com/assets/images/clearsight-logos/color-logo@2x-458a9655.png)](https://clearsightstudio.com/)

ProMotion for screens and RMQ for styles, animations, traversing, events, etc.

## Quick start

```
gem install red_potion

potion create my_app
bundle
rake pod:install
potion create model state
potion create table_screen states
 # a few changes
rake
```

![image](https://camo.githubusercontent.com/fa0ac0a77e6170cca72f03f9ad2273c5b165e83d/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f313437393231352f313533343331372f35613134656632382d346339332d313165332d386539652d6638633038643834363466382e706e67)

## Contributing

1. Fork it
2. Create your feature branch (`git checkoutut -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
