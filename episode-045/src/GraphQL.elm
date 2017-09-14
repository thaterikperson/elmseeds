module GraphQL exposing (..)


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
