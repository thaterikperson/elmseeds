module Main exposing (..)

import FileReader exposing (NativeFile)
import Http exposing (stringPart, Request)
import Json.Decode as JD exposing (Decoder)
import Model exposing (..)
import Navigation exposing (Location)
import Routes exposing (Page(..))
import Task
import View
import MimeType exposing (..)


main : Program Never Model Msg
main =
    Navigation.program
        UrlChange
        { init = initialState
        , update = update
        , view = View.mainView
        , subscriptions = (\_ -> Sub.none)
        }


initialState : Location -> ( Model, Cmd Msg )
initialState location =
    modelWithLocation location initialModel ! []


modelWithLocation : Location -> Model -> Model
modelWithLocation location model =
    let
        page =
            location
                |> Routes.pathParser
                |> Maybe.withDefault Home
    in
        { model | page = page }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Files nativeFiles ->
            let
                file =
                    List.head nativeFiles

                cmd =
                    file
                        |> Maybe.map (\file -> FileReader.readAsDataUrl file.blob)
                        |> Maybe.map (Task.attempt FileRead)
                        |> Maybe.withDefault Cmd.none
            in
                { model | fileToUpload = file } ! [ cmd ]

        FileRead result ->
            let
                src =
                    result
                        |> Debug.log "FileRead"
                        |> Result.mapError (\_ -> "")
                        |> Result.andThen (JD.decodeValue JD.string)
                        |> Result.toMaybe
            in
                { model | encodedFile = src } ! []

        DragOver ->
            { model | isFileHovering = True, message = "Drop the file to crop and upload it." } ! []

        DragLeave ->
            { model | isFileHovering = False, message = "Drop your image file here." } ! []

        DropFiles nativeFiles ->
            let
                file =
                    List.head nativeFiles

                cmd =
                    file
                        |> Maybe.map (\file -> FileReader.readAsDataUrl file.blob)
                        |> Maybe.map (Task.attempt FileRead)
                        |> Maybe.withDefault Cmd.none
            in
                case file of
                    Nothing ->
                        model ! []

                    Just f ->
                        case f.mimeType of
                            Just (Image Jpeg) ->
                                { model | fileToUpload = file, isFileHovering = False, message = "Drop your image file here." } ! [ cmd ]

                            Just (Image Png) ->
                                { model | fileToUpload = file, isFileHovering = False, message = "Drop your image file here." } ! [ cmd ]

                            _ ->
                                model ! []

        UploadImage ->
            let
                cmd =
                    Http.get "/credentials" credentialsDecoder
                        |> Http.send CredentialsResult
            in
                model ! [ cmd ]

        CredentialsResult (Ok result) ->
            let
                cmd =
                    model.fileToUpload
                        |> Maybe.map
                            (\file ->
                                uploadRequest result file
                                    |> Http.send UploadComplete
                            )
                        |> Maybe.withDefault Cmd.none
            in
                model ! [ cmd ]

        CredentialsResult (Err error) ->
            let
                _ =
                    Debug.log "error" error
            in
                model ! []

        UploadComplete (Ok result) ->
            let
                _ =
                    Debug.log "result" result
            in
                model ! []

        UploadComplete (Err error) ->
            let
                _ =
                    Debug.log "error" error
            in
                model ! []

        ToggleMenu ->
            { model | isMenuOpen = not model.isMenuOpen } ! []

        UrlChange location ->
            modelWithLocation location model ! []

        NavigateTo page ->
            let
                cmd =
                    Navigation.newUrl (Routes.pageToPath page)
            in
                model ! [ cmd ]


uploadRequest : Credentials -> NativeFile -> Request String
uploadRequest creds file =
    Http.request
        { method = "POST"
        , headers = []
        , url = "https://elmseeds-s3.s3.amazonaws.com"
        , body = multiPartBody creds file
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }


multiPartBody : Credentials -> FileReader.NativeFile -> Http.Body
multiPartBody creds nf =
    Http.multipartBody
        [ stringPart "key" nf.name
        , stringPart "x-amz-algorithm" "AWS4-HMAC-SHA256"
        , stringPart "x-amz-credential" creds.credential
        , stringPart "x-amz-date" creds.date
        , stringPart "policy" creds.policy
        , stringPart "x-amz-signature" creds.signature
        , FileReader.filePart "file" nf
        ]


credentialsDecoder : Decoder Credentials
credentialsDecoder =
    JD.map4 Credentials
        (JD.field "credential" JD.string)
        (JD.field "date" JD.string)
        (JD.field "policy" JD.string)
        (JD.field "signature" JD.string)
