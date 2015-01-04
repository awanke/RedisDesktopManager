import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs 1.2

import "."

AbstractEditor {
    id: root
    anchors.fill: parent

    Text {
        Layout.fillWidth: true
        text: "Key:"
    }

    TextField {
        id: keyText

        Layout.fillWidth: true
        Layout.minimumHeight: 35

        text: ""
        enabled: originalValue != "" || !editingMode
        property string originalValue: ""

        style: TextFieldStyle {
                background: Rectangle {
                radius: 1
                implicitWidth: 100
                implicitHeight: 24
                border.color: "#BFBFBF"
                border.width: 1
                color: (textArea.text=="" && textArea.enabled
                                      && textArea.readOnly == false) ? "lightyellow" : "white"
                }
         }
    }

    Text {
        Layout.fillWidth: true
        text: "Value:"
    }

    TextArea {
        id: textArea
        Layout.fillWidth: true
        Layout.fillHeight: true
        text: ""
        enabled: originalValue != "" || !editingMode
        property string originalValue: ""

        style: TextAreaStyle {
            backgroundColor: (textArea.text=="" && textArea.enabled
                              && textArea.readOnly == false) ? "lightyellow" : "white"
        }
    }

    function setValue(rowValue) {

        if (!rowValue)
            return

        keyText.originalValue = rowValue['key']
        keyText.text = rowValue['key']
        textArea.originalValue = rowValue['value']
        textArea.text = rowValue['value']
    }

    function isValueChanged() {
        return textArea.originalValue != textArea.text
                || keyText.originalValue != keyText.text
    }

    function resetAndDisableEditor() {
        textArea.originalValue = ""
        textArea.text = ""
        keyText.originalValue = ""
        keyText.text = ""
    }

    function getValue() {
        return {"value": textArea.text, "key": keyText.text}
    }

    function isValueValid() {
        var value = getValue()

        return value && value['key'] && value['value']
                && value['key'].length > 0
                && value['value'].length > 0
    }

    function markInvalidFields() {
        keyText.textColor = "black"
        textArea.textColor = "black"


        keyText.textColor = "red"
    }
}