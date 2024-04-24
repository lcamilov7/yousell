import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['sidebar']

  connect() {
    // El metodo connect se ejecuta una vez haya un elemento en el dom con data-controller='modal'
    // y esto ocurrira cuando con turbo frame insertemios ese div dandole clic a add product.
    // Luego con este timeout que se ejecuta una vez que ese div esta insertado, le quitamos la clase full y agregamos 0 esto para poder ver la animacion de apertura de sidebar
    setTimeout(() => {
      this.sidebarTarget.classList.remove('translate-x-full');
      this.sidebarTarget.classList.add('translate-x-0');
    }, 50);

    this.element.addEventListener('turbo:submit-end', (event) => { // Agregamos un event listener al element (div con data-controller='modal') que sera de tipo submit
      if (event.detail.success) { // si el submit devuelve respuesta exitosa entonces hacemos la linea siguiente
        Turbo.visit(event.detail.fetchResponse.response.url) // Esta linea hace un 'redirect' a la url que apunta el form al hacer submit url la cual definimos en el controlador de product en el metodo create
      }
    })
  }

  close() {
    this.sidebarTarget.classList.remove('translate-x-0');
    this.sidebarTarget.classList.add('translate-x-full');

    setTimeout(() => { // Este timeout es para que haya que esperar 350 milisegundos para ajecutar lo que hay dentro, sin este timeout no podriamos ver la animacion de cierre de la sidebar
      this.element.parentElement.removeAttribute('src') // Esto para quitar el src del turbo frame tag que es padre del div con el data-controller='modal' ya que se pone automaticamente al realizar el render del turbo frame tag
      this.element.remove() // Esto elimina todo el elemento data controller modal y todo dentro de el
    }, 350);
  }
}
