---
layout: post
title:  "Publish a Package"
date:   2016-07-07 12:30:00 -0500
categories:
label: ep-007
tiny_description: Create and publish your own package.
---

Creating and publishing a package to [package.elm-lang.org](http://package.elm-lang.org) is easier than you might think. It requires hosting your module on Github and fully documenting any types and functions you want to expose. Tests are not enforced, but you should include them anyway. The `elm-package` tool will enforce proper semantic versioning. With those in place, `elm-package publish` will make your module available for anyone to use.

Follow the [Design Guidelines](http://package.elm-lang.org/help/design-guidelines) for more tips on writing your API the Elm Way.

### Links

* [elm-lang/elm-package](https://github.com/elm-lang/elm-package/blob/master/README.md)
* [thaterikperson/elm-blackjack](https://github.com/thaterikperson/elm-blackjack)
* [Documentation Format](http://package.elm-lang.org/help/documentation-format)
* [Doc Preview](http://package.elm-lang.org/help/docs-preview)
