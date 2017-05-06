---
layout: post
title:  "React Native with Elm"
date:   2017-05-05 11:44:00 -0400
categories:
label: ep-033
number: 33
tiny_description: Build a basic React Native app using Elm.
---

Because Elm compiles into Javascript, it's a candidate to be used with [React Native](https://facebook.github.io/react-native/) to build native iOS and Android applications.
Use [ohanhi/elm-native-ui](https://github.com/ohanhi/elm-native-ui) to handle the main application and view layer, and the rest of the Elm architecture to build runtime error-free mobile apps.

### Examples

**index.ios.js**

```js
const { AppRegistry } = require('react-native');
const Elm = require('./elm');
const component = Elm.Main.start();

AppRegistry.registerComponent('CardCounter', () => component);
```

**Main.elm**

```elm
import NativeUi as Ui exposing (Node)
import NativeUi.Style as Style exposing (defaultTransform)
import NativeUi.Elements as Elements exposing (..)
import NativeUi.Events exposing (..)
import NativeUi.Image as Image exposing (..)

main : Program Never Model Msg
main =
    Ui.program
        { init = ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

```

#### Links

* [React Native - Getting Started](https://facebook.github.io/react-native/docs/getting-started.html)
* [Writing a React Native app in Elm](http://ohanhi.com/elm-native-ui.html)
