import { Controller } from '@hotwired/stimulus'
import { createConsumer } from '@rails/actioncable'

// Connects to data-controller="websocket-product"
export default class extends Controller {
  connect() {
    // channel = al canal que creamos en app/channels, el rrom es para especificar que solo del product que estamos viendo, no queremos crear canal para todos al mismo tiempo
    createConsumer().subscriptions.create({ channel: 'ProductChannel', room: this.element.dataset.productid }, { // this element es el element donde esta el data-controller en el dom, con dataset accedemos a los atributos tipo data y queremos buscar el que es productid
      received(data) { // data es el contenido que mandamos en el metodo notify_all_users en el products_controller#update
        if (data.action === 'updated') {
          location.reload()
        }
      }
    })
  }
}
