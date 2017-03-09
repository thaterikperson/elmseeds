import "phoenix_html"
import Elm from './main'

const div = document.getElementById('main')
div.innerHTML = ''
let main = Elm.Main.embed(div)

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
