module GraphQL
    exposing
        ( Node
        , Param
        , ParamType(..)
        , query
        , node
        , prop
        , toString
        , fragment
        , fields
        , Fragment
        )


type Fragment
    = Fragment String (Node -> Node)


type Node
    = Node
        { name : String
        , params : List Param
        , properties : List Node
        , fragments : List Node
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
        newNode ("query " ++ name) newParams


paramTypeToParam : ParamType -> Param
paramTypeToParam type_ =
    case type_ of
        Int key ->
            Param key "Int"

        String key ->
            Param key "String"


newNode : String -> List Param -> Node
newNode name params =
    Node { name = name, params = params, properties = [], fragments = [] }


node : String -> List Param -> (Node -> Node) -> Node -> Node
node name params propertiesFunc (Node parent) =
    let
        node =
            newNode name params
                |> propertiesFunc
    in
        Node { parent | properties = node :: parent.properties }


prop : String -> Node -> Node
prop name parent =
    node name [] identity parent


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



{- Debug Functions Below -}


toString : Node -> String
toString node =
    let
        frags =
            extractFragments node []
                |> List.map (toStringPretty 0)
                |> String.join "\n"
    in
        frags ++ "\n" ++ (toStringPretty 0 node)


toStringPretty : Int -> Node -> String
toStringPretty depth (Node node) =
    let
        tabs =
            "\t"
                |> List.repeat depth
                |> String.join ""
    in
        if List.length node.properties > 0 then
            let
                line1 =
                    tabs ++ node.name ++ (paramsToString node.params) ++ " {\n"

                middleLines =
                    node.properties
                        |> List.reverse
                        |> List.map (toStringPretty (depth + 1))
                        |> String.join "\n"
                        |> flip (++) "\n"

                lastLine =
                    tabs ++ "}\n"
            in
                line1 ++ middleLines ++ lastLine
        else
            tabs ++ node.name


extractFragments : Node -> List Node -> List Node
extractFragments (Node node) existing =
    let
        new =
            node.fragments ++ existing

        fromProps =
            node.properties
                |> List.map (\n -> extractFragments n [])
                |> List.concat
    in
        fromProps ++ new


paramTypesToString : List ParamType -> String
paramTypesToString list =
    if List.length list > 0 then
        list
            |> List.reverse
            |> List.map paramTypeToString
            |> String.join ", "
            |> (++) "("
            |> flip (++) ")"
    else
        ""


paramTypeToString : ParamType -> String
paramTypeToString paramType =
    case paramType of
        Int value ->
            value ++ ": Int"

        String value ->
            value ++ ": String"


paramsToString : List Param -> String
paramsToString list =
    if List.length list > 0 then
        list
            |> List.reverse
            |> List.map (\{ name, value } -> name ++ ": " ++ value)
            |> String.join ", "
            |> (++) "("
            |> flip (++) ")"
    else
        ""
