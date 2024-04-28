// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "trix"
import "@rails/actiontext"
import "jquery"
import "jquery_ujs"
import 'popper'
import 'bootstrap'