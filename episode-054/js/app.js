import Elm from '../src/Main.elm'

const div = document.getElementById('main')
window.main = Elm.Main.embed(div)
