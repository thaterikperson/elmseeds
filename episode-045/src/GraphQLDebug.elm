module GraphQLDebug exposing (toString)

import GraphQL exposing (..)


toString : Node -> String
toString (Node node) =
    let
        line1 =
            node.name ++ (paramsToString node.params) ++ " {\n"

        middleLines =
            node.properties
                |> List.reverse
                |> List.map toString
                |> String.join "\n"

        lastLine =
            "\n}"
    in
        if List.length node.properties > 0 then
            line1 ++ middleLines ++ lastLine
        else
            node.name


paramTypesToString : List ParamType -> String
paramTypesToString list =
    if List.length list > 0 then
        list
            |> List.reverse
            |> List.map paramTypeToString
            |> String.join ", "
            |> (++) "("
            |> flip (++) (")")
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
            |> flip (++) (")")
    else
        ""
