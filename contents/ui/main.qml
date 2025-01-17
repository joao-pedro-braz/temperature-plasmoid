import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Layout.minimumHeight: 1
    Layout.preferredHeight: 2
    anchors.topMargin: -16
	
     PlasmaComponents.Label {
        anchors.left: parent.left
        anchors.right: parent.right
	Layout.fillHeight: false
        id: log
        horizontalAlignment: Text.AlignHCenter
	text: ""
     }

    // update the view
    function showInfo(temperature) {
        log.text = temperature + " °C"
    }

    function request() {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.DONE) {
                var result = JSON.parse(doc.responseText);
		showInfo(result.forecasts[0].detailed.reports[0].temperatureC);
            }
        }
        doc.open("GET", "https://weather-broker-cdn.api.bbci.co.uk/en/forecast/aggregated/3460535");
        doc.send();
    }

    Timer {
        running: true
        repeat: true
        triggeredOnStart: true
        interval: 1000
        onTriggered: request()
    }
}
