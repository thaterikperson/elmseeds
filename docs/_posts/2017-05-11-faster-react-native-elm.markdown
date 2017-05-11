---
layout: post
title:  "Development Tips for React Native with Elm"
date:   2017-05-11 15:05:00 -0400
categories:
label: ep-034
number: 34
tiny_description: Speed up your React Native development.
---

[Episode 33](/react-native-elm) introduced developing React Native applications with Elm, but the development process was slow, to say the least. In this episode, we cover a few tips that will greatly decrease the time between saving a file and seeing the results in the simulator.

### Examples

```sh
npm run watch
```

**package.json**

```json
{
  // …
  "scripts": {
    "compile": "elm-make Main.elm --output elm.js",
    "start": "node node_modules/react-native/local-cli/cli.js start",
    "test": "jest",
    "watch": "chokidar '*.elm' -c 'npm run compile'"
  }
  // …
}

```
