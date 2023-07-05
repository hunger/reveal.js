use slint::slint;

slint! {

import { Button, VerticalBox } from "std-widgets.slint";

export component AppWindow {
    VerticalBox {
        Button { text: "Hello World"; }
    }
}

}

fn main() {
    let app = AppWindow::new().unwrap();

    app.run().unwrap();
}
