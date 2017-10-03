function Map_ ( {
    var _mp = {};
    this.set = function(k,v) {
        _set(k,v);
    }
    
    this.add = function(k,v) {
        _set(k,v);
    }
    
    this.get = function(k){
        return _mp[k];
    }
    
    this.has = function(k){
        return (_mp[k] != undefined);
    }
    
    this._set = function(_k,_v){
         mp[k] = v;
    }
	//return _mp;
});