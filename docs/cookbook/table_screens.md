There are two types of templates in RedPotion for tables:

* Metal tables: "Metal" meaning down to the metal. These are standard SDK tables, that are converted into ProMotion screens
* ProMotion tables: These are easy to use and if you don't have tons of rows they would be a good choice.

## Metal tables

### To create

```
potion create table_screen foo
```

## ProMotion tables (Table Screen)

ProMotion::TableScreen allows you to easily create lists or "tables" as iOS calls them. It's a subclass of [UITableViewController](http://developer.apple.com/library/ios/#documentation/uikit/reference/UITableViewController_Class/Reference/Reference.html) and has all the goodness of [PM::Screen](https://github.com/clearsightstudio/ProMotion/wiki/API-Reference:-ProMotion::Screen) with some additional magic to make the tables work beautifully.

|Table Screens|Grouped Tables|Searchable|Refreshable|
|---|---|---|---|
|![ProMotion TableScreen](https://f.cloud.github.com/assets/1479215/1534137/ed71e864-4c90-11e3-98aa-ed96049f5407.png)|![Grouped Table Screen](https://f.cloud.github.com/assets/1479215/1589973/61a48610-5281-11e3-85ac-abee99bf73ad.png)|![Searchable](https://f.cloud.github.com/assets/1479215/1534299/20cc05c6-4c93-11e3-92ca-9ee39c044457.png)|![Refreshable](https://f.cloud.github.com/assets/1479215/1534317/5a14ef28-4c93-11e3-8e9e-f8c08d8464f8.png)|

### To create

```
potion create table_screen foo
```

[ProMotion table docs](https://github.com/clearsightstudio/ProMotion/blob/master/docs/Reference/API%20Reference%20-%20ProMotion%20TableScreen.md)


### Add a custom cell

We almost always use custom cells, rather than rely on the default ones provided by the SDK. To create a custom cell (or many different cell types) for your table screen, do this:

```
potion create table_screen_cell bar_cell
```

Then follow the directions in the files that were created.
