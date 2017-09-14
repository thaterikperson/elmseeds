---
layout: post
title:  "GraphQL Query Builder"
date:   2017-09-14 14:00:00 -0400
categories:
label: ep-045
number: 45
tiny_description: Build GraphQL queries in a composable manner.
---

If you use GraphQL in your project, you may find yourself building queries via string concatenation. While that does technically work, it's safer to use some kind of query builder.

This simple module allows you to build and compose complex queries, and have the structure of your code map very closely to the raw query text.

### Examples

**Main.elm**

```elm
query =
    GraphQL.query "GetUser" [ Int "$id" ]
        |> node "user" [ Param "id" "$id" ]
            (\user ->
                user
                    |> prop "id"
                    |> prop "email"
                    |> prop "name"
                    |> node "address" []
                        (\address ->
                            address
                                |> prop "city"
                                |> prop "state"
                        )
            )
```

**GraphQL.elm**

```elm
type Node
    = Node
        { name : String
        , params : List Param
        , properties : List Node
        }


type alias Param =
    { name : String, value : String }


type ParamType
    = Int String
    | String String


query : String -> List ParamType -> Node
query name params =
    let
        newParams =
            List.map paramTypeToParam params
    in
        Node { name = "query " ++ name, params = newParams, properties = [] }


paramTypeToParam : ParamType -> Param
paramTypeToParam type_ =
    case type_ of
        Int key ->
            Param key "Int"

        String key ->
            Param key "String"


node : String -> List Param -> (Node -> Node) -> Node -> Node
node name params propertiesFunc (Node parent) =
    let
        node =
            Node { name = name, params = params, properties = [] }
                |> propertiesFunc
    in
        Node { parent | properties = node :: parent.properties }


prop : String -> Node -> Node
prop name parent =
    node name [] identity parent

```
