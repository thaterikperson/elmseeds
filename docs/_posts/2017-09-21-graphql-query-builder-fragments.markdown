---
layout: post
title:  "GraphQL Fragments"
date:   2017-09-21 14:00:00 -0400
categories:
label: ep-046
number: 46
tiny_description: Add fragment support to last episode's GraphQL query builder.
---

Fragments are reusable chunks of GraphQL queries that can help reduce code duplication across queries. We want to add support for them in our query builder so we can benefit from their reusability.

### Examples

**Main.elm**

```elm
addressFragment : Fragment
addressFragment =
    fragment "Address" address


addressFields : Node -> Node
addressFields node =
    fields addressFragment node


user : Node -> Node
user user =
    user
        |> prop "id"
        |> prop "email"
        |> prop "name"
        |> node "address" [] addressFields
```

**GraphQL.elm**

```elm
type Fragment
    = Fragment String (Node -> Node)


fragment : String -> (Node -> Node) -> Fragment
fragment name func =
    Fragment name func


fields : Fragment -> Node -> Node
fields (Fragment typeName func) parent =
    let
        fieldsName =
            (String.toLower typeName) ++ "Fields"

        fragment_ =
            newNode ("fragment " ++ fieldsName ++ " on " ++ typeName) []
                |> func

        (Node node) =
            prop ("..." ++ fieldsName) parent
    in
        Node { node | fragments = fragment_ :: node.fragments }

```

#### Links

* [Fragments](http://graphql.org/learn/queries/#fragments)
