# Using a local database

RedPotion uses Core Data as its local data store. Specifically it uses the [CDQ](https://github.com/infinitered/cdq) gem.

## Schema

Now go edit schemas/0001_initial.rb.  There's some commented-out example code
in it.  Go ahead and uncomment the example entities and save the file.  It should
look like this:

```ruby
schema "0001 initial" do

  # Examples:
  #
  entity "Person" do
    string :name, optional: false
    has_many :posts
  end

  entity "Post" do
    string :title, optional: false
    string :body

    datetime :created_at
    datetime :updated_at
    has_many :replies, inverse: "Post.parent"
    belongs_to :parent, inverse: "Post.replies"

    belongs_to :person
  end

end
```

## Models

Now to generate models for the entities, Person and Post, that you've just set up
in the schema.  CDQ includes a handy generator to save a little time:

```bash
$ cdq create model person
$ cdq create model post
```

## Creating Data

You're now ready to run rake and start playing with your data.  The simulator
should come up cleanly.

Once you have a console prompt, start creating some data:

```ruby
marie = Person.create(name: "Marie Skłodowska")
pierre = Person.create(name: "Pierre Curie")
post = marie.posts.create(title: "First Post", body: "This stuff seems to be glowing.", created_at: Time.now)
post.replies.create(title: "Marry Me!", body: "That is so freaking amazing!", person: pierre, created_at: Time.now)
cdq.save
```

Note that unlike ActiveRecord, created_at will not (currently) get set
automatically. 

Now quit the app and restart so you can verify that things are
saving to disk correctly.

### An aside about data faults

When you're looking around, you may notice something strange.  Sometimes when
you run a query, especially for the first time, you get a result like this:

```ruby
(main)> Person.all.array
=> [<Person: 0x9288d30> (entity: Person; id: 0x9285150 <x-coredata://FD49F7ED-9459-4675-A00F-4CF8B6C1419E/Person/p1> ; data: <fault>), <Person: 0x9288f80> (entity: Person; id: 0x9285160 <x-coredata://FD49F7ED-9459-4675-A00F-4CF8B6C1419E/Person/p2> ; data: <fault>)]
```

Very compact.  But other times, it might look like this:

```ruby
(main)> Person.all.map(&:name)
=> ["Marie Skłodowska", "Pierre Curie"]
(main)> Person.all.array
=> [<Person: 0x9288d30> (entity: Person; id: 0x9285150 <x-coredata://FD49F7ED-9459-4675-A00F-4CF8B6C1419E/Person/p1> ; data: {
    name = "Marie Sk\U0142odowska";
    posts = "<relationship fault: 0x9280260 'posts'>";
}), <Person: 0x9288f80> (entity: Person; id: 0x9285160 <x-coredata://FD49F7ED-9459-4675-A00F-4CF8B6C1419E/Person/p2> ; data: {
    name = "Pierre Curie";
    posts = "<relationship fault: 0x9290540 'posts'>";
})]

```

Not so compact, but more useful.  What's going on?  Core Data is very smart
about how much data to load, and won't go fetch the details of an object until
they're used.  So in the first example, I'd just loaded the app and hadn't used
anything yet, so you see the text ```data: <fault>``` in there indicating that
it hasn't fetched the attributes from the SQLite database that actually holds
all your data.  In the second example, I deliberately loop through each object
and ask it for data, so now when I print out the collection, it shouls you all the
attributes.  But you'll note that for posts, it still says "relationship fault", 
because we haven't asked it about posts yet. Turtles all the way down.

## Queries

Now try some queries:

```ruby
pierre = Person.where(:name).contains("Pierre").first
marie = Person.where(:name).ne("Pierre Curie").first
Post.where(:person).eq(pierre).array
Post.sort_by(:title).first
Post.sort_by(:created_at)[1]
Post.count
```

Create some more data and then run the queries again, or try some new combinations.  

## Cheatsheet

```ruby
cdq.setup                # Load the whole system

cdq.contexts.current     # The currently-active NSManagedObjectContext
cdq.contexts.all         # See all contexts on the stack
cdq.contexts.new(type)   # Create a new context and push it onto the stack

cdq.save                 # Save all contexts on the stack
```

## Object Lifecycle

### Creating
```ruby
  Author.create(name: "Le Guin", publish_count: 150, first_published: 1970)
  Author.create(name: "Shakespeare", publish_count: 400, first_published: 1550)
  Author.create(name: "Blake", publish_count: 100, first_published: 1778)
  cdq.save
```

### Updating
```ruby
  author = Author.first
  author.name = "Ursula K. Le Guin"
  cdq.save
```

### Deleting
```ruby
  author = Author.first
  author.destroy
  cdq.save
```

## Queries

```ruby
Author.where(:name).eq("Emily")
Author.where(:name).not_equal("Emily")
Author.limit(1)
Author.offset(10)
Author.where(:name).contains("A").offset(10).first

# Conjuctions
Author.where(:name).contains("Emily").and.contains("Dickinson")
Author.where(:name).begins_with("E").or(:pub_count).eq(1)
Post.where(:date).ge(start_date).and.le(end_date) # gt, ge (greater or equal), lt, le (less or equal)

# Nested Conjuctions
Author.where(:name).contains("Emily").and(cdq(:pub_count).gt(100).or.lt(10))

# Relationships
Author.first.publications.offset(2).limit(1)
cdq(emily_dickinson).publications.where(:type).eq('poetry')

# Sorting
Author.sort_by(:name)
Author.sort_by(:name, order: :descending, case_insensitive: true)
```

## Scopes

```ruby
class Author < CDQManagedObject
  scope :prolific, where(:pub_count).gt(50)
end
```

## Operators

Many short-form operators also have verbose equivalents.

```
eq (equal)
ne (not_equal)
lt (less_than)
le (less_than_or_equal)
gt (greater_than)
ge (greater_than_or_equal)
contains
matches
in
begins_with
ends_with
between
```

## Accessors

These methods pull you out of CDQ-land and return actual objects or values.
They go at the end of a query or scope and will force execution.

```
array (to_a)
first
map
each
[]
```

