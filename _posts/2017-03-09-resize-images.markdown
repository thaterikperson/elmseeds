---
layout: post
title:  "Resize Images"
date:   2017-03-09 16:00:00 -0500
categories:
label: ep-027
number: 27
tiny_description: Resize and image using canvas on the client.
---

It is possible to resize images in the client's web browser using the canvas API. This eliminates the need for your server to do the work, and allows the client to [upload the correct file directly to S3](/upload-to-s3). We use the same [simonh1000/file-reader](https://github.com/simonh1000/file-reader) module as the last two weeks, which allows us to pass native `File` objects through `ports` to a canvas for drawing.


### Examples

**app.js**

```js
main.ports.crop.subscribe(function (options) {
  let img = new Image()
  img.src = options.imgSrc
  let canvas = document.createElement('canvas')
  canvas.width = options.dim
  canvas.height = options.dim
  canvas.getContext('2d').drawImage(img, options.x, options.y, options.dim, options.dim, 0, 0, options.dim, options.dim)
  canvas.toBlob(function (blob) {
    main.ports.incomingCroppedFile.send(new File([blob], "cropped.jpg"))
  })
})
```

**Main.elm**

```elm
update msg model =
    case msg of
        MouseUp ( upX, upY ) ->
            let
                -- …
                cmd =
                    case model.encodedFile of
                        Just imgSrc ->
                            crop { imgSrc = imgSrc, x = downX, y = downY, dim = dim }

                        Nothing ->
                            Cmd.none
            in
                model ! [ cmd ]

        IncomingCroppedFile blob ->
            let
                file =
                    JD.decodeValue nativeFileDecoder blob
                        |> Result.toMaybe
            in
                { model | fileToUpload = file } ! []


port crop : { imgSrc : String, x : Float, y : Float, dim : Float } -> Cmd msg


port incomingCroppedFile : (JD.Value -> msg) -> Sub msg
```

#### Links

* [simonh1000/file-reader](https://github.com/simonh1000/file-reader)
