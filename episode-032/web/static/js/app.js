import "phoenix_html"
import Elm from './main'

const div = document.getElementById('main')
div.innerHTML = ''
let main = Elm.Main.embed(div)
