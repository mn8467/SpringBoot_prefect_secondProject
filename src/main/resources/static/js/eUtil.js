let eUtil = {}
   
    
eUtil.isEmpty = function(str){
                       if(null !== str  || undefined !== str){
                           str = str.toString();
                           
                           //공백 제거: " pcwk " => "pcwk"
                           if(str.replace(/ /gi, "").length == 0){
                               return true;
                           }
                       }
                       
                       return false;
                   }
   