
  function SizeShip() {
    var offsetFactor = 250;
    var offset = 1;
    var ship = document.getElementById('ship-view');
    ship.setAttribute("width", window.innerWidth + "px");
    ship.setAttribute("height", window.innerHeight - (offset * offsetFactor) + "px");
    ship.setAttribute("viewBox", "0 " + offset + " 85.284628 24.493283");
  }

  SizeShip();

  onresize = function () {
    SizeShip();
  }



document.getElementById('CSR1CLICK').addEventListener('click', function(e){window.location.href="{{@BASE}}/dashboard/dynamic_rack/CSR1"; });


function Refresh() {
    $.ajax({
        url: "/api/events/ALL",
        success: function (data) {
            document.getElementById("CSR1").style.fill = 'green';
            //document.getElementById("CSR1").style.fill = 'green';
            //document.getElementById("RADIO").style.fill = 'green';
            data.forEach(function(e){
                if(e.location!=""){
                    if(e.status==0){
                        document.getElementById(e.location).style.fill = 'green';
                    }else if(e.status==1){
                        document.getElementById(e.location).style.fill = 'orange';
                    }else if(e.status==2){
                        document.getElementById(e.location).style.fill = 'red';
                    }
                }

            });
           
        setTimeout(Refresh, 10000);
        }
    });
}
Refresh();
setTimeout(Refresh, 10000);