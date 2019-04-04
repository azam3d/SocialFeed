#  Style Guide

**Naming**

Don't put `self` for constant and variable, except in closure

Create properties with nil using Optional. Properties that initialized with empty string or 0 is the pre-Swift practised when Optional type wasn’t exist.

Put constants and variables on top of the class, functions should be below them.

When we create a method for button, we should name it as `Tapped()` instead of `Pressed()`

Class names should be nouns only. Methods should be verb only.

Naming variables and methods should be clear and concise. Our documentation is on good naming and self-explained codes, not by comments.

Comment only for non-obvious methods. This extension shoudn't be commented because the comment only repeat the protocol name

```
// MARK: ListAdapterDataSource
extension FollowingViewController: ListAdapterDataSource {
func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
return data
}
}
```


Put a space if you create a new condition or loop. eg:

```
var x: Int!

if x = 5 {
print("xxxxx")
}
```

We put fileprivate for variables and methods to make sure it can't be access from the object of the class or struct. We also know that it is the methods that we create for the class or struct itself. It's a kind of self documentation that will save our time.


