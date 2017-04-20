---
layout: post
title:  "Preview Images and Drag & Drop"
date:   2017-03-02 09:06:00 -0500
categories:
label: ep-026
number: 26
tiny_description: Drag and drop a file onto your app so it can be previewed.
---

Using the same [simonh1000/file-reader](https://github.com/simonh1000/file-reader) module as [last week](/upload-to-s3), we can enable an app to read the contents of the chosen file and display a preview of it to the user. Combine this with some custom `onWithOptions` calls in our view, and we can enable drag and drop support rather than forcing the user to use a clunky file chooser.


### Examples

**Main.elm**

```elm
update msg model =
    case msg of
        FileRead result ->
            let
                src =
                    result
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
              { model | fileToUpload = file } ! [ cmd ]
```

**View.elm**

```elm
div
    [ classList
        [ ( "drop-form", True )
        , ( "drop-form-hover", model.isFileHovering )
        , ( "drop-error", model.isBadFileType )
        ]
    , onWithOptions "dragover" { preventDefault = True, stopPropagation = True } (Json.map (\_ -> DragOver) Json.value)
    , onWithOptions "dragleave" { preventDefault = True, stopPropagation = True } (Json.map (\_ -> DragLeave) Json.value)
    , onWithOptions "drop" { preventDefault = True, stopPropagation = True } (Json.map DropFiles parseDroppedFiles)
    ]
    [ text model.message
    ]
```

#### Links

* [simonh1000/file-reader](https://github.com/simonh1000/file-reader)
* [Upload to S3](/upload-to-s3)
