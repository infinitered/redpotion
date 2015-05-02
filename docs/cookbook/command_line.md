## Live stylesheet reloading

In REPL, type: `live`

![image](http://clrsight.co/jh/LiveReload4.gif?+)

------

## Fancy printing

RedPotion uses [motion_print](https://github.com/OTGApps/motion_print) for fancy console output.

Instead of `puts`, use `mp`:

```ruby
> mp({b: "bee", a: 'a', see: 4})

{
  a     => a,
  b     => bee,
  see   => 4
}
```

------

## Generators

Like Rails, RedPotion provides a command-line tool, mostly for generating files. 

**Create a new app**:

```
> potion create my_app
```

To get all the commands available just do:

```
> potion

potion version 1.1.1

Some things you can do with the potion command:

> potion create my_new_app
> potion create my_new_app --skip-cdq # Setup application without CDQ

> potion create model foo
> potion create screen foo
> potion create table_screen foo
> potion create table_screen_cell bar_cell
> potion create metal_table_screen foo
> potion create collection_view_screen foos
> potion create view bar
> potion create shared some_class_used_app_wide
> potion create lib some_class_used_by_multiple_apps

You can still create controllers, but you should create screens instead
> potion create controller foos
> potion create collection_view_controller foos
> potion create table_view_controller bars

You can remove CDQ or afmotion if your project does not use it
> potion remove cdq
> potion remove afmotion

Misc
> potion -h, --help
> potion -v, --version

Documentation
> rmq docs
> rmq docs query
> rmq docs "background image"```
```

I recomend you play around with it, do this:

```
> cd
> cd Desktop
> potion create test_app
> cd test_app
> bundle
> rake pod:install
> rake spec
> rake
> potion create screen test
> potion create table_screen test_table
> potion create view test_view
```

------

## Console Fun

----

```ruby
rmq.log :tree

─── UIView  ( root_view )  4525363712  {l: 0, t: 0, w: 320, h: 568}
    ├─── UILabel  ( hello_world )  4526498928  {l: 60, t: 269, w: 200, h: 30}
    ├─── HelloWorldSection  ( section )  4614724352  {l: 60, t: 100, w: 200, h: 100}
    │    ├─── UIButton  ( section_button )  4614736128  {l: 5, t: 5, w: 80, h: 20}
    │    │    ├─── UIButtonLabel  4526568160  {l: 13, t: -1, w: 54.5, h: 21.5}
    ├─── UIButton  ( open_table_button )  4614749936  {l: 60, t: 428, w: 200, h: 20}
    │    ├─── UIButtonLabel  4526561536  {l: 26.5, t: -1, w: 147.5, h: 21.5}
    ├─── UIButton  ( open_metal_table_button )  4614761424  {l: 60, t: 458, w: 200, h: 20}
    │    ├─── UIButtonLabel  4526553984  {l: 1.5, t: -1, w: 197, h: 21.5}
    ├─── UIButton  ( open_data_table_button )  4649398928  {l: 60, t: 488, w: 200, h: 20}
    │    ├─── UIButtonLabel  4526547280  {l: 6, t: -1, w: 188.5, h: 21.5}
    ├─── UIButton  ( open_example_controller_ )  4649417104  {l: 60, t: 518, w: 200, h: 20}
    │    ├─── UIButtonLabel  4526537936  {l: 1, t: -1, w: 198, h: 21.5}
```

```ruby
find.all.log

 object_id   | class                 | style_name              | frame                           |
 sv id       | superview             | subviews count          | tags                            |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526498928  | UILabel               | hello_world             | {l: 60, t: 269, w: 200, h: 30}  |
 4525363712  | UIView                | 0                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4614724352  | HelloWorldSection     | section                 | {l: 60, t: 100, w: 200, h: 100} |
 4525363712  | UIView                | 1                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4614736128  | UIButton              | section_button          | {l: 5, t: 5, w: 80, h: 20}      |
 4614724352  | HelloWorldSection     | 1                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526568160  | UIButtonLabel         |                         | {l: 13, t: -1, w: 54.5, h: 21.5}|
 4614736128  | UIButton              | 0                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4614749936  | UIButton              | open_table_button       | {l: 60, t: 428, w: 200, h: 20}  |
 4525363712  | UIView                | 1                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526561536  | UIButtonLabel         |                         | {l: 26.5, t: -1, w: 147.5, h: 21.5}|
 4614749936  | UIButton              | 0                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4614761424  | UIButton              | open_metal_table_button | {l: 60, t: 458, w: 200, h: 20}  |
 4525363712  | UIView                | 1                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526553984  | UIButtonLabel         |                         | {l: 1.5, t: -1, w: 197, h: 21.5}|
 4614761424  | UIButton              | 0                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4649398928  | UIButton              | open_data_table_button  | {l: 60, t: 488, w: 200, h: 20}  |
 4525363712  | UIView                | 1                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526547280  | UIButtonLabel         |                         | {l: 6, t: -1, w: 188.5, h: 21.5}|
 4649398928  | UIButton              | 0                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4649417104  | UIButton              | open_example_controller_| {l: 60, t: 518, w: 200, h: 20}  |
 4525363712  | UIView                | 1                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526537936  | UIButtonLabel         |                         | {l: 1, t: -1, w: 198, h: 21.5}  |
 4649417104  | UIButton              | 0                       |                                 |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
RMQ 4649676656. 12 selected. selectors: []
```

```ruby
find.all.log :wide

 object_id   | class                 | style_name              | frame                           | sv id       | superview             | subviews count          | tags                            |
 - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - | - - - - - - | - - - - - - - - - - - | - - - - - - - - - - - - | - - - - - - - - - - - - - - - - |
 4526498928  | UILabel               | hello_world             | {l: 60, t: 269, w: 200, h: 30}  | 4525363712  | UIView                | 0                       |                                 |
 4614724352  | HelloWorldSection     | section                 | {l: 60, t: 100, w: 200, h: 100} | 4525363712  | UIView                | 1                       |                                 |
 4614736128  | UIButton              | section_button          | {l: 5, t: 5, w: 80, h: 20}      | 4614724352  | HelloWorldSection     | 1                       |                                 |
 4526568160  | UIButtonLabel         |                         | {l: 13, t: -1, w: 54.5, h: 21.5}| 4614736128  | UIButton              | 0                       |                                 |
 4614749936  | UIButton              | open_table_button       | {l: 60, t: 428, w: 200, h: 20}  | 4525363712  | UIView                | 1                       |                                 |
 4526561536  | UIButtonLabel         |                         | {l: 26.5, t: 1, w: 147.5, h: 21}| 4614749936  | UIButton              | 0                       |                                 |
 4614761424  | UIButton              | open_metal_table_button | {l: 60, t: 458, w: 200, h: 20}  | 4525363712  | UIView                | 1                       |                                 |
 4526553984  | UIButtonLabel         |                         | {l: 1.5, t: -1, w: 197, h: 21.5}| 4614761424  | UIButton              | 0                       |                                 |
 4649398928  | UIButton              | open_data_table_button  | {l: 60, t: 488, w: 200, h: 20}  | 4525363712  | UIView                | 1                       |                                 |
 4526547280  | UIButtonLabel         |                         | {l: 6, t: -1, w: 188.5, h: 21.5}| 4649398928  | UIButton              | 0                       |                                 |
 4649417104  | UIButton              | open_example_controller_| {l: 60, t: 518, w: 200, h: 20}  | 4525363712  | UIView                | 1                       |                                 |
 4526537936  | UIButtonLabel         |                         | {l: 1, t: -1, w: 198, h: 21.5}  | 4649417104  | UIButton              | 0                       |                                 |
RMQ 4668847808. 12 selected. selectors: []
```

```ruby
find(HelloWorldSection).frame.log

 *****************---*******---**************************
 *                 |         |                          *    window
 *            100 top        |                          *    {w: 320, h: 568}
 *                 |         |                          *
 *                ---        |                          *    superview
 *            ***************|*****   ---               *    {w: 320, h: 568}
 *            *              |    *    |                *
 *            *              |    *    |                *
 *            *       200 bottom  *    |                *    view
 *    60      *              |    *    |                *    {l: 60, t: 100,
 *|-- left --|*              |    *    |                *     w: 200, h: 100}
 *            *              |    * height 100          *
 *            *              |    *    |                *    z_order: 1
 *            *       260    |    *    |                *    z_position: 0.0
 *|------------------ right -+---|*    |                *
 *            *              |    *    |    60          *    Location in root view
 *            *              |    * |--+--from_right---|*    {l: 60, t: 100,
 *            *             ---   *    |                *     w: 200, h: 100}
 *            ***************---***   ---               *
 *                            |                         *
 *            |------ width - + --|                     *
 *                    200     |                         *
 *                            |                         *
 *                            |                         *
 *                    368 from_bottom                   *
 *                            |                         *
 *                           ---                        *
 ******
```

```ruby
find(UIView).show
find(UILabel).animations.blink
find(UIButton).nudge l: 10
```
