let removeLocalStorage = key => Dom.Storage.localStorage->Dom.Storage2.removeItem(key)

let setLocalStorage = (key, data) => Dom.Storage.localStorage->Dom.Storage2.setItem(key, data)

let getFromLocalStorage = key => Dom.Storage.localStorage->Dom.Storage2.getItem(key)

let getFormTargetValue = e => ReactEvent.Form.target(e)["value"]
