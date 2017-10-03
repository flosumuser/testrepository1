 function saveContent() {
    var patchname = $("input[class='sname']").val();
    console.log(patchname);
    if(patchname != '' && patchname.length>1) {
    statusFeed('Saving...','info');
    
    var mfiles = JSON.stringify(metypes).replace(/\\n/g,"").replace("amp;","").replace("&quot;",'"');
    
    $("input[id$='mfiles']").val(mfiles);
    $("input[id$='patch']").val(''+patchname);
    $("input[id$='zip']").val(zipf);
    saveMetadata();
    
    } else {
    	statusFeed('Please enter patch name','warning');
    }
  }
  
  
 
  function handleSave(r,e) {
  	if (e.status) {
        statusFeed('Metadata Saved Successfully','confirm');
    } else if (e.type === 'exception') {
        statusFeed(e.message,'error');
    } else {
       statusFeed('Unknown Exception Occurred: '+e.message,'error');
    }
  }