var _user$project$Native = function() {

  function setItem(key, value) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      localStorage.setItem(key, value)
      callback(_elm_lang$core$Native_Scheduler.succeed(key));
    });
  }

  function getItem(key) {
    return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
      var value = localStorage.getItem(key)
      if (value === null) {
        value = ""
      }
      callback(_elm_lang$core$Native_Scheduler.succeed(value));
    });
  }

  return {
    setItem: F2(setItem),
    getItem: getItem
  }
}();
