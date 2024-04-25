puts '### Clearing database ###'
User.destroy_all
Product.destroy_all
Favorite.destroy_all
Category.destroy_all
puts '### Database clear ###'

puts '### Creating users ###'
sara = User.create!(username: 'raticavivaz4', email: 'saraposada@gmail.com', password: 'testme4444', admin: true) # No ponemos digest
pepe = User.create!(username: 'erpepe06genial', email: 'erpepe06@hotmail.com', password: 'testme4444')
luis = User.create!(username: 'lcamilov7', email: 'luiscamilov@hotmail.com', password: 'testme4444')
puts '### Users created ###'

puts '### Creating categories ###'
videogames = Category.create!(name: 'Videogames')
computers = Category.create!(name: 'Computers')
clothes = Category.create!(name: 'Clothes')
cars = Category.create!(name: 'Cars')
music = Category.create!(name: 'Music')
electronic = Category.create!(name: 'Electronic')
books = Category.create!(name: 'Books')
mobile = Category.create!(name: 'Mobile')
sports = Category.create!(name: 'Sports')
puts '### Categories created ###'

puts '### Creating products ###'
ps4 = sara.products.create(category_id: videogames.id, title: 'PS4 Fat', description: 'PS4 en buen estado', price: 150)
ps4.photo.attach(io: File.open('app/assets/images/ps4.jpg'), filename: 'ps4.jpg')

switch = luis.products.create(category_id: videogames.id, title: 'Nintendo Switch', description: 'Le falla el lector de tarjeta SD', price: 195)
switch.photo.attach(io: File.open('app/assets/images/switch.jpg'), filename: 'switch.jpg')

shirt = sara.products.create(category_id: clothes.id, title: 'Camisita', description: 'Camisita talla M', price: 10)
shirt.photo.attach(io: File.open('app/assets/images/shirt.jpg'), filename: 'shirt.jpg')

nintendo64 = luis.products.create(category_id: videogames.id, title: 'Nintendo 64 en buen estado', description: 'Con su caja, solo tiene algún pequeño arañazo', price: 190)
nintendo64.photo.attach(io: File.open('app/assets/images/nintendo64.jpg'), filename: 'nintendo65.jpg')

megadrive = sara.products.create(category_id: videogames.id, title: 'Sega Megadrive', description: 'Funciona perfectamente, solo consola', price: 90)
megadrive.photo.attach(io: File.open('app/assets/images/megadrive.jpg'), filename: 'megadrive.jpg')

driver2 = luis.products.create(category_id: videogames.id, title: 'Driver 2 para ps1', description: 'Como nuevo en su caja y con instrucciones', price: 25)
driver2.photo.attach(io: File.open('app/assets/images/driver2.jpg'), filename: 'driver2.jpg')

ps5 = pepe.products.create(category_id: videogames.id, title: 'PS5 nueva sin lector', description: 'A estrenar, usada solo dos veces.', price: 650)
ps5.photo.attach(io: File.open('app/assets/images/ps5.jpg'), filename: 'ps5.jpg')

gameboy = luis.products.create(category_id: videogames.id, title: 'Game Boy Color', description: 'Con su caja. Color morada transparente.', price: 150)
gameboy.photo.attach(io: File.open('app/assets/images/gameboy.jpg'), filename: 'gameboy.jpg')

air = pepe.products.create(category_id: computers.id, title: 'Macbook Air', description: 'Le falla la batería', price: 250)
air.photo.attach(io: File.open('app/assets/images/air.jpg'), filename: 'air.jpg')

imac = pepe.products.create(category_id: computers.id, title: 'iMac 27" 2015', description: 'i5 con 8gb de ram y SSD', price: 90)
imac.photo.attach(io: File.open('app/assets/images/imac.jpg'), filename: 'imac.jpg')

ryzen = luis.products.create(category_id: computers.id, title: 'Ryzen 5950x', description: 'Sin estrenar precintado como nuevo', price: 590)
ryzen.photo.attach(io: File.open('app/assets/images/ryzen.jpg'), filename: 'ryzen.jpg')

nvidia = pepe.products.create(category_id: computers.id, title: 'Nvidia 3090ti', description: 'Solo usada 3 meses la vendo porque no la uso', price: 1500)
nvidia.photo.attach(io: File.open('app/assets/images/nvidia.jpg'), filename: 'nvidia.jpg')

ram = sara.products.create(category_id: computers.id, title: '16GB Ram DDR4 3200mhz', description: 'Funciona perfectamente', price: 95)
ram.photo.attach(io: File.open('app/assets/images/ram.jpg'), filename: 'ram.jpg')

renault = pepe.products.create(category_id: cars.id, title: 'Renault Clio 2009', description: '85000km, 95cv', price: 4500)
renault.photo.attach(io: File.open('app/assets/images/renault.jpg'), filename: 'renault.jpg')

seat = luis.products.create(category_id: cars.id, title: 'Seat Panda clásico', description: 'Tan solo 90000km, 75cv. Del año 1980', price: 5500)
seat.photo.attach(io: File.open('app/assets/images/seat.jpg'), filename: 'seat.jpg')

michael = sara.products.create(category_id: music.id, title: 'Vinilo Michael Jackson Thriller', description: 'Como nuevo a estrenar', price: 45)
michael.photo.attach(io: File.open('app/assets/images/michael.jpg'), filename: 'michael.jpg')

queen = luis.products.create(category_id: music.id, title: 'Vinilo Queen', description: 'Ligeras marcas de uso de los años 80', price: 35)
queen.photo.attach(io: File.open('app/assets/images/queen.jpg'), filename: 'queen.jpg')

tv = sara.products.create(category_id: electronic.id, title: 'Televisión LG 48 pulgadas', description: 'Viene con smart TV funciona perfectamente', price: 350)
tv.photo.attach(io: File.open('app/assets/images/tv.jpg'), filename: 'tv.jpg')

kindle = pepe.products.create(category_id: electronic.id, title: 'Lector de libros Kindle 2010', description: 'Tiene marcas de uso pero funciona bien', price: 35)
kindle.photo.attach(io: File.open('app/assets/images/kindle.jpg'), filename: 'kindle.jpg')

ipod = luis.products.create(category_id: electronic.id, title: 'iPod touch', description: 'Como nuevo a estrenar con su caja', price: 175)
ipod.photo.attach(io: File.open('app/assets/images/ipod.jpg'), filename: 'ipod.jpg')

harry = sara.products.create(category_id: books.id, title: 'Colección entera de Harry Potter', description: 'Todos los libros de la saga. Bien cuidados!', price: 65)
harry.photo.attach(io: File.open('app/assets/images/harry.jpg'), filename: 'harry.jpg')

hobbit = pepe.products.create(category_id: books.id, title: 'El hobbit', description: 'Libro en buen estado', price: 15)
hobbit.photo.attach(io: File.open('app/assets/images/hobbit.jpg'), filename: 'hobbit.jpg')

iphone = sara.products.create(category_id: mobile.id, title: 'iPhone 13', description: 'Funciona correctamente.', price: 400)
iphone.photo.attach(io: File.open('app/assets/images/iphone.jpg'), filename: 'iphone.jpg')

pixel = pepe.products.create(category_id: mobile.id, title: 'Google Pixel 4', description: 'Le falla la batería', price: 100)
pixel.photo.attach(io: File.open('app/assets/images/pixel.jpg'), filename: 'pixel.jpg')

surf = luis.products.create(category_id: sports.id, title: 'Tabla de surf', description: 'Usada dos veces. Como nueva.', price: 125)
surf.photo.attach(io: File.open('app/assets/images/surf.jpg'), filename: 'surf.jpg')

tennis = sara.products.create(category_id: sports.id, title: 'Raqueta de tenis profesional', description: 'Fabricada en fibra de carbono. Solo un par de arañazos', price: 135)
tennis.photo.attach(io: File.open('app/assets/images/tennis.jpg'), filename: 'tennis.jpg')

skate = sara.products.create(category_id: sports.id, title: 'Skateboard', description: 'Como nuevo con las ruedas recién cambiadas', price: 75)
skate.photo.attach(io: File.open('app/assets/images/skate.jpg'), filename: 'skate.jpg')
puts '### Products created ###'

puts '### Creating Favorites ###'

puts '### Favorites created ###'
puts 'SEED RUNNED'
