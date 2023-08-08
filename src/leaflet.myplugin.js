import L from "leaflet";
import "./myplugin.css";

L.Control.mypluginControl = L.Control.extend({});

L.Control.mypluginConstructor = function (options) {
    return new L.Control.mypluginControl(options);
}
