!function(){"use strict";var queryString={};queryString.parse=function(str){return"string"!=typeof str?{}:(str=str.trim().replace(/^(\?|#)/,""),str?str.trim().split("&").reduce(function(ret,param){var parts=param.replace(/\+/g," ").split("="),key=parts[0],val=parts[1];return key=decodeURIComponent(key),val=void 0===val?null:decodeURIComponent(val),ret.hasOwnProperty(key)?Array.isArray(ret[key])?ret[key].push(val):ret[key]=[ret[key],val]:ret[key]=val,ret},{}):{})},queryString.stringify=function(obj){return obj?Object.keys(obj).map(function(key){var val=obj[key];return Array.isArray(val)?val.map(function(val2){return encodeURIComponent(key)+"="+encodeURIComponent(val2)}).join("&"):encodeURIComponent(key)+"="+encodeURIComponent(val)}).join("&"):""},window.queryString=queryString}(),function(){var __indexOf=[].indexOf||function(item){for(var i=0,l=this.length;l>i;i++)if(i in this&&this[i]===item)return i;return-1};!function(){"use strict";var $internalPrototype,$overlay,$prototypeDiv,$settingCheckbox,$settingDiv,$settingTextbox,CONFIG,doneValues,labelText,name,prototypeConfig,prototypeIndex,prototypeName,qs,queryStringObj,setting,settings,value,_ref;if("undefined"==typeof NYTD&&(window.NYTD={}),window.NYTD.InternalPrototype={},CONFIG={prototypes:{"Full Bleed":{on:!0,settings:{safezone:"0,1152,700,1350",image:"http://static01.nyt.com/images/2015/01/18/magazine/18naming1-copy/18naming1-copy-superJumbo-v3.jpg"}}}},window.NYTD.InternalPrototype.reload=function(){var name,queryStringObj;$(".internalPrototype-prototype").each(function(){var name;return name=$(this).find(".prototypename").text(),$(this).find("input[type=checkbox]").prop("checked")?$(this).find(".internalPrototype-prototype-setting").each(function(){var settingname,val;return val=$(this).find("input[type=text]").val(),settingname=$(this).find(".settingname").text(),CONFIG.prototypes[name].settings[settingname]=val}):CONFIG.prototypes[name].on=!1});for(name in CONFIG.prototypes)queryStringObj={prototype:name,on:CONFIG.prototypes[name].on,settings:decodeURIComponent(JSON.stringify(CONFIG.prototypes[name].settings))};return location.search=decodeURIComponent(queryString.stringify(queryStringObj))},!location.search){for(name in CONFIG.prototypes)CONFIG.prototypes[name].on&&(queryStringObj={prototype:name,on:CONFIG.prototypes[name].on,settings:decodeURIComponent(JSON.stringify(CONFIG.prototypes[name].settings))});return void(location.search=decodeURIComponent(queryString.stringify(queryStringObj)))}qs=queryString.parse(location.search),settings=JSON.parse(qs.settings);for(name in CONFIG.prototypes){CONFIG.prototypes[name].on="true"===qs.on;for(setting in CONFIG.prototypes[name].settings)CONFIG.prototypes[name].settings[setting]=settings[setting]}$("#internalPrototype-overlay").remove(),$overlay=$('<div id="internalPrototype-overlay" style="\n    position: fixed; z-index: 9999; top: 0; bottom: 0; left: 0; right: 0;\n    background-color: rgba(0,0,0,0.8); cursor: pointer;\n">\n    <style>\n        #internalPrototype {\n            margin: 12px 18px; padding: 1px 18px; background-color: #eee;\n            font: 14px helvetica, arial, sans-serif;\n            -webkit-user-select:none;\n            -khtml-user-select:none;\n            -moz-user-select:none;\n            -o-user-select:none;\n            user-select:none;\n            cursor: default;\n        }\n        #internalPrototype .nonstring {\n            font-style: italic;\n        }\n        #internalPrototype input, #internalPrototype label {\n            cursor: pointer;\n        }\n        #internalPrototype label {\n            margin: 6px 0;\n        }\n        #internalPrototype .internalPrototype-prototype:not(.forced) .internalPrototype-prototype-variant input,\n        #internalPrototype .internalPrototype-prototype:not(.forced) .internalPrototype-prototype-variant label {\n            cursor: default;\n            color: #999;\n        }\n        .internalPrototype-prototype {\n            margin: 12px 0;\n        }\n        .internalPrototype-prototype-name {\n            display: block\n        }\n        .internalPrototype-prototype-variant {\n            display: block;\n            margin-left: 18px\n        }\n    </style>\n    <div id="internalPrototype">\n        <p><b>Prototypes (v1):</b></p>\n    </div>\n</div>'),$overlay.on("click",function(){return $overlay.remove()}),$internalPrototype=$overlay.find("#internalPrototype"),$internalPrototype.on("click",function(e){return e.stopPropagation()}),prototypeIndex=0,_ref=CONFIG.prototypes;for(prototypeName in _ref){prototypeConfig=_ref[prototypeName],prototypeIndex+=1,$prototypeDiv=$('<div class="internalPrototype-prototype">\n    <div class="internalPrototype-prototype-name"><label>\n        <input type="checkbox"> <span class="prototypename"></span>:\n    </label></div>\n</div>'),$prototypeDiv.find(".prototypename").text(prototypeName),$prototypeDiv.find("input[type=checkbox]").prop("checked",prototypeConfig.on),doneValues=[];for(value in prototypeConfig.settings)__indexOf.call(doneValues,value)>=0||(doneValues.push(value),labelText="string"==typeof value?value:String(value),$settingDiv=$('<div class="internalPrototype-prototype-setting"><label>\n    <span class="settingname"></span>\n    <input type="text" name="prototype-'+prototypeIndex+'-setting-text" />\n</label></div>'),$settingDiv.find(".settingname").addClass("string"!=typeof value?"nonstring":void 0).text(labelText),$settingCheckbox=$settingDiv.find("input[type=checkbox]"),$settingTextbox=$settingDiv.find("input[type=text]"),$settingTextbox.val(prototypeConfig.settings[value]),$settingCheckbox.data("value",value).data("prototypeName",prototypeName),$settingDiv.appendTo($prototypeDiv));$prototypeDiv.appendTo($internalPrototype)}$internalPrototype.append('<p style="font-size: smaller">* currently active; <a href="#" onclick="window.NYTD.InternalPrototype.reload(); return false">reload</a> to apply changes</p>'),$(document.body).append($overlay)}()}.call(this);