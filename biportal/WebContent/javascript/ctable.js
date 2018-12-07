
Array.prototype.each=function(f){for(var   i=0;i<this.length;i++)   f(this[i],i,this)} 
  
function   $Ar(arrayLike){ 
for(var   i=0,ret=[];i<arrayLike.length;i++)   ret.push(arrayLike[i]); 
return   ret 
} 
  
Function.prototype.bind   =   function()   { 
      var   __method   =   this,   args   =   $Ar(arguments),   object   =   args.shift(); 
      return   function()   { 
          return   __method.apply(object,   args.concat($Ar(arguments))); 
      } 
}  
function   CTable(id,rows){ 
this.tbl=typeof(id)=="string"?document.getElementById(id):id;   
if   (rows   &&   /^\d+$/.test(rows))   this.addrows(rows) 
} 
  
CTable.prototype={ 
addrows:function(n){                      
new   Array(n).each(this.add.bind(this)); 
},


del:function(){                      
var   self=this; 
$Ar(self.tbl.tBodies[0].rows).each(function(tr){if   (self.getChkBox(tr).checked)   tr.parentNode.removeChild(tr)}) 
}, 
up:function(){                             
var   self=this; 
var   upOne=function(tr){                     
if   (tr.rowIndex>1){ 
self.swapTr(tr,self.tbl.rows[tr.rowIndex-1]); 
self.getChkBox(tr).checked=true ;
} 
} 
var   arr=$Ar(self.tbl.tBodies[0].rows).reverse() ;
if   (arr.length>0   &&   self.getChkBox(arr[arr.length-1]).checked){ 
for(var   i=arr.length-1;i>=0;i--){ 
if   (self.getChkBox(arr[i]).checked){ 
arr.pop();                       
}else{ 
break; 
} 
} 
} 
arr.reverse().each(function(tr){if   (self.getChkBox(tr).checked)   upOne(tr);}); 
}, 
down:function(){ 
var   self=this ;
var   downOne=function(tr){             
if   (tr.rowIndex<self.tbl.rows.length-1)     { 
self.swapTr(tr,self.tbl.rows[tr.rowIndex+1]); 
self.getChkBox(tr).checked=true; 
} 
} 
var   arr=$Ar(self.tbl.tBodies[0].rows); 
  
if   (arr.length>0   &&   self.getChkBox(arr[arr.length-1]).checked){ 
for(var   i=arr.length-1;i>=0;i--){ 
if   (self.getChkBox(arr[i]).checked){ 
arr.pop(); 
}else{ 
break ;
} 
} 
} 
arr.reverse().each(function(tr){if   (self.getChkBox(tr).checked)   downOne(tr)}); 
}, 
sort:function(){           
var self=this,order=arguments[0];
var sortBy=function(a,b){
if (typeof(order)=="number"){  
return Number(jQuery('input[type=text]',a.cells[order])[0].value)>=Number(jQuery('input[type=text]',b.cells[order])[0].value)?1:-1;   
}else if (typeof(order)=="function"){     
return order(a,b);
}else{
return 1;
}
}
$Ar(self.tbl.tBodies[0].rows).sort(sortBy).each(function(x){



var checkStatus=self.getChkBox(x).checked;
self.tbl.tBodies[0].appendChild(x);

if (checkStatus) self.getChkBox(x).checked=checkStatus;
});
},
sortDown:function(){           
var self=this,order=arguments[0];
var sortBy=function(a,b){
if (typeof(order)=="number"){  
return Number(jQuery('input[type=text]',a.cells[order])[0].value)<=Number(jQuery('input[type=text]',b.cells[order])[0].value)?1:-1;   
}else if (typeof(order)=="function"){     
return order(a,b);
}else{
return 1;
}
}
$Ar(self.tbl.tBodies[0].rows).sort(sortBy).each(function(x){



var checkStatus=self.getChkBox(x).checked;
self.tbl.tBodies[0].appendChild(x);

if (checkStatus) self.getChkBox(x).checked=checkStatus;
});
},
rnd:function(){                      
var   self=this,selmax=0,tbl=self.tbl; 
if   (tbl.rows.length){ 
    selmax=Math.max(Math.ceil(tbl.rows.length/4),1);     
    $Ar(tbl.rows).each(function(x){ 
self.getChkBox(x).checked=false; 
self.restoreBgColor(x) 
}) 
}else{ 
return   alert("No source selected!") 
} 
new   Array(selmax).each(function(){ 
var   tr=tbl.rows[Math.floor(Math.random()*tbl.rows.length)] 
self.getChkBox(tr).checked=true; 
self.highlight({target:self.getChkBox(tr)}) 
}) 
}, 
highlight:function(){                            
var   self=this; 
var   evt=arguments[0]   ||   window.event 
var   chkbox=evt.srcElement   ||   evt.target 
var   tr=chkbox.parentNode.parentNode 
chkbox.checked?self.setBgColor(tr):self.restoreBgColor(tr) 
}, 
swapTr:function(tr1,tr2){                           
var   target=(tr1.rowIndex<tr2.rowIndex)?tr2.nextSibling:tr2; 
var   tBody=tr1.parentNode 
tBody.replaceChild(tr2,tr1); 
          tBody.insertBefore(tr1,target); 
}, 
getChkBox:function(tr){                       
var  trcheckboxtmp=jQuery('input[type=checkbox]',tr);
return trcheckboxtmp[0];
}, 
restoreBgColor:function(tr){                     
tr.style.backgroundColor="#ffffff"   
}, 
setBgColor:function(tr){ 
tr.style.backgroundColor="#c0c0c0" 
} 
} 
  
function   f(a,b){ 
var   sumRow=function(row){return   Number(row.cells[1].innerHTML)+Number(row.cells[2].innerHTML)}; 
return   sumRow(a)>sumRow(b)?1:-1; 
}