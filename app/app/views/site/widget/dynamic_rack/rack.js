
$(".status-data").css("background-color", "green");
$(".status-cable").css("background-color", "grey");
function Refresh() {
    $(".status-data").css("background-color", "green");
    $(".status-cable").css("background-color", "grey");
    $.ajax({
        url: "/api/events/{{@location}}",
        success: function (data) {
            
            data.forEach(function(e){
                if(e.name=="" || e.name==null){
                    console.log("Error Missing Name");
                }else{
                    if(e.status==0){
                        $("#"+e.name).css("background-color", "green");
                    }else if(e.status==1){
                        $("#"+e.name).css("background-color", "orange");
                    }else if(e.status==2){
                        $("#"+e.name).css("background-color", "red");
                    }
                }
                
            });
            //console.log(data);
            //console.log(data.name);
            
        //$('#widget{{ @uid }}').html(data);
        setTimeout(Refresh, 10000);
        }
    });
}

Refresh();
setTimeout(Refresh, 10000);

