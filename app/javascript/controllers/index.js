// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import ClipboardButtonController from "./clipboard_button_controller";
application.register("clipboard-button", ClipboardButtonController);

import EditLinkController from "./edit_link_controller";
application.register("edit-link", EditLinkController);

import HelloController from "./hello_controller";
application.register("hello", HelloController);
import SubmitOnChangeController from "./submit_on_change_controller";
application.register("submit-on-change", SubmitOnChangeController);
