
    $(document).ready(function(){
        $("#analysistool").change(function(){
           // Grab the id of the selected analysis tool and temporarily display it.
             var id = $("#reportview_analysistool_id").val()
          
           $.ajax({
             type: "POST",
             url: "/reportviews/update_buginfo_select",
           data:  ({
               id : id
             }),             
             success: function(result)
             {
                alert('hello');
             } 
            });

          });
      });

          <script type="text/javascript">
jQuery(document).ready(function() {

      $('#filter_objem').attr("disabled", "disable");

      $('#filter_objem').empty();
        $('#marka').attr("disabled", "disable");
          $('#filter_ves').change(function(){
          var vesJs = $("#filter_ves :selected").text();

            $.ajax({
                   type: "GET",
                   url: "/tenders/update_objem_select",
                   //dataType: "script",
                  data:  ({
                     vesJs : vesJs
                   }),             
                   success: function(result)
                   {
                      alert(result);
                      $('#filter_objem').removeAttr("disabled");
                   } 
                  });
          
          //alert(vesJs);
          return false;
        });



      //$('#tender_driver').attr("disabled", !1)
   /*  country = $('#tender_driver').html()
     alert(country)
      $('#tender_company').change(function() {


        continent = $('#tender_company :selected').text()
        options = $(country).filter("[label='#{continent}'']").html()
        alert(options)
        if (options)
           $('#tender_driver').html(options)
        else
            $('#tender_driver').empty()
      });*/
   




});
</script>