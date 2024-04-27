import { Controller } from '@hotwired/stimulus'
import { createConsumer } from '@rails/actioncable'

// Connects to data-controller="websocket-product"
export default class extends Controller {
  connect() {
    // channel = al canal que creamos en app/channels, el rrom es para especificar que solo del product que estamos viendo, no queremos crear canal para todos al mismo tiempo
    createConsumer().subscriptions.create({ channel: 'ProductChannel', room: '27' }, {
      received(data) { // data es el contenido que mandamos en el metodo notify_all_users en el products_controller#update
        if (data.action === 'updated') {
          location.reload()
        }
      }
    })
  }
}
