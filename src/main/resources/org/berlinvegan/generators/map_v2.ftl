<#ftl encoding="ISO-8859-1">
<#-- @ftlvariable name="language" type="java.lang.String" -->
<#-- @ftlvariable name="i18n" type="java.util.ResourceBundle" -->
<#-- @ftlvariable name="openTimesI18N" type="java.lang.String" -->
<#-- @ftlvariable name="reviewbase" type="java.lang.String" -->
<#-- @ftlvariable name="restaurants" type="org.berlinvegan.generators.model.GastroLocation[]" -->
<#-- @ftlvariable name="restaurant" type="org.berlinvegan.generators.model.GastroLocation" -->
<#-- @ftlvariable name="districts" type="java.lang.String[]" -->
<script type='text/javascript' src='https://maps.google.com/maps/api/js?sensor=false'></script>
<script type="text/javascript">
    <#include "maphelper.js">
</script>
<script type='text/javascript'>

    var infowindow = new google.maps.InfoWindow({maxWidth: 350});
    var markersArray = [];
    var map;
    function initialize() {
        var latlng = new google.maps.LatLng(52.518611, 13.388056);
        var myOptions = {
            zoom: 12,
            center: latlng,
            mapTypeControl: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    <#assign i=0>
    <#list restaurants as restaurant>
        <#if restaurant.latCoord??>
            latlng = new google.maps.LatLng(${restaurant.latCoord?string["0.#######"]},${restaurant.longCoord?string["0.#######"]});
            markersArray[${i}] = new google.maps.Marker({
                position: latlng,
                map: map,
                title: "${restaurant.name}",
                bv_dog: "${restaurant.dog}",
                bv_bio: "${restaurant.organic}",
                bv_glutenFree: "${restaurant.glutenFree}",
                bv_wlan: "${restaurant.wlan}",
                bv_rollstuhl: "${restaurant.handicappedAccessible}",
                bv_vegan: "${restaurant.vegan}",
                bv_open: ["${restaurant.otMon}", "${restaurant.otTue}", "${restaurant.otWed}", "${restaurant.otThu}", "${restaurant.otFri}", "${restaurant.otSat}", "${restaurant.otSun}"],
                bv_district: "${restaurant.district}"
            });
            google.maps.event.addListener(markersArray[${i}], 'click', function () {
                var infoStr = "<b>${restaurant.name}</b><br/><br/>${restaurant.street}, ${restaurant.cityCode?c} ${restaurant.district}";
                <#if restaurant.website??>
                    infoStr += ' ( <a target="_blank" href="http://${restaurant.website?js_string}">Webseite</a> )';
                </#if>
                infoStr += "<br/><br/><b>�ffnungszeiten:</b><br/><br/> ${restaurant.getOpenTimesHTML(language)}";
                infoStr = infoStr + "<br><b>${restaurant.getVeganHTML(language)}</b>";

                <#if restaurant.reviewURL??>
                    infoStr += '<br/><a href="${reviewbase}${restaurant.reviewURL}">${restaurant.name} Restaurantkritik</a>';
                <#else>
                    <#if restaurant.comment??>
                        infoStr += '<br/>${restaurant.comment?js_string}';
                    </#if>
                </#if>

                infoStr = "<div>" + infoStr + "</div><br/>";
                infowindow.setContent(infoStr);
                infowindow.open(map, markersArray[${i}]);
            });
            <#assign i = i +1>
        </#if>
    </#list>
    }
</script>
Bezirk: <select id="districtselect" name="district" size="1" onChange="updateMarkers(markersArray);">
    <option>Alle Bezirke</option>
<#list districts?sort as district>
    <option>${district}</option>
</#list>
</select>

<input id="completevegancheckbox" onChange="updateMarkers(markersArray);" type="checkbox">100% vegan</input>
<input id="opencheckbox" onChange="updateMarkers(markersArray);" type="checkbox">jetzt ge�ffnet</input>
<input id="biocheckbox" onChange="updateMarkers(markersArray);" type="checkbox">Bio</input>
<input id="glutenfreecheckbox" onChange="updateMarkers(markersArray);" type="checkbox">glutenfreie Speisen</input>
<input id="rollstuhlcheckbox" onChange="updateMarkers(markersArray);" type="checkbox">Rollstuhl geeignet</input>
<input id="dogcheckbox" onChange="updateMarkers(markersArray);" type="checkbox">Hunde erlaubt</input>
<input id="wlancheckbox" onChange="updateMarkers(markersArray);" type="checkbox">WLAN</input>


<div id="map_canvas" style="margin-top:5px;line-height:1.0em; height:630px"></div>
Die Karte umfasst insgesamt <b>${restaurants?size}</b> Restaurants/Bistros/Cafes. Die veganen Speisen sind deklariert.