---
layout: post
title:  "Sorted Dictionary"
date:   2017-08-17 14:16:00 -0400
categories:
label: ep-044
number: 44
tiny_description: Use a Tree structure to create a sorted dictionary.
---

A step-by-step walkthrough of building our own sorted dictionary data structure using a `Tree` sum type as our basis. Our goal is to keep the api as compatible with the `Dict` api as possible.

### Examples

**SortedDict.elm**

```elm
type alias Dict k v =
    { comparer : v -> v -> Order
    , tree : Tree k v
    }


type Tree k v
    = Empty
    | Node k v (Tree k v) (Tree k v)


empty : (v -> v -> Order) -> Dict k v
empty comparer =
    { comparer = comparer
    , tree = Empty
    }


insert : k -> v -> Dict k v -> Dict k v
insert newKey newValue dict =
    { dict | tree = doInsert newKey newValue dict.comparer dict.tree }


doInsert : k -> v -> (v -> v -> Order) -> Tree k v -> Tree k v
doInsert newKey newValue comparer tree =
    case tree of
        Empty ->
            Node newKey newValue Empty Empty

        Node key value left right ->
            if newKey == key then
                Node key newValue left right
            else
                case comparer newValue value of
                    GT ->
                        Node key value left (doInsert newKey newValue comparer right)

                    _ ->
                        Node key value (doInsert newKey newValue comparer left) right


values : Dict k v -> List v
values dict =
    doValues dict.tree []


doValues : Tree k v -> List v -> List v
doValues tree list =
    case tree of
        Empty ->
            list

        Node _ value left right ->
            doValues right ((doValues left list) ++ [ value ])

```
