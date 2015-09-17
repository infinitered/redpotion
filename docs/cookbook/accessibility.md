## Accessibility

### motion-accessibility gem

[motion-accessibility](https://github.com/austinseraphin/motion-accessibility) gem.

In your gemfile:

```
gem "motion-accessibility"
```

This gem has RedPotion capabilities. You can test any selection for accessibility. For example:

```
it "has accessible buttons" do
  find(UIButton).should.be.accessible
end
```

### Future

We're currently adding new features to RedPotion, such as disabling animations when VoiceOver is turned on.


