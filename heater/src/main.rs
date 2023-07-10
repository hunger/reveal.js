use slint::slint;

use heater::{add, div};

slint! {

import { Button, VerticalBox , TextEdit, HorizontalBox} from "std-widgets.slint";

export component AppWindow {
    in property<int> result;
    in-out property<string> i1;
    in-out property<string> i2;

    callback process(string, string, string);

    VerticalBox {
        HorizontalBox { 
            TextInput { width: 100px; text <=> root.i1; }
            TextInput { width: 100px; text <=> root.i2; }
        }
        HorizontalBox {
        Button {
            text: "add";
            clicked => {
               root.process(root.i1, root.i2, "add");
            }
        }
        Button {
            text: "div";
            clicked => {
                root.process(root.i1, root.i2, "div");
            }
        }
        }
        Text { width: 200px; height: 20px; text: root.result; }
    }
}

}

/// <- starts here!
fn main() {
    let app = AppWindow::new().unwrap();

    let a = app.as_weak();
    app.on_process(move |i1: slint::SharedString, i2: slint::SharedString, op: slint::SharedString| {
        let Ok(i1) = i1.as_str().parse::<i32>() else { return; };
        let Ok(i2) = i2.as_str().parse::<i32>() else { return; };

        let result = match op.as_str() {
            "add" => add(i1, i2),
            "div" => div(i1, i2),
            _ => { return },
        };
        eprintln!("{i1} {op} {i2} = {result}");
        a.upgrade().unwrap().set_result(result);
    });

    app.run().unwrap();
}
